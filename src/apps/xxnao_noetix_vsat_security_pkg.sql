-- Purpose: APPS.XXNAO_VSAT_SECURITY_PKG
--
-- MODIFICATION HISTORY
-- Person      Date         Comments
-- ---------   ------       ------------------------------------------
-- Srini Akula 09-Nov-2014  Created.
-- Srini Akula 10-Nov-2014  Added mask_rate and mask_account functions.
-- Srini Akula 19-Nov-2014  Added view_project, update_project and view_cost functions
--			    required for the finance security.

CREATE OR REPLACE PACKAGE APPS.xxnao_noetix_vsat_security_pkg
IS
   FUNCTION mask_rate (p_user_name IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION mask_account (p_user_name IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION view_project (p_user_name IN VARCHAR2)
      RETURN VARCHAR2;
      
   FUNCTION update_project (p_user_name IN VARCHAR2)
      RETURN VARCHAR2;   

   FUNCTION view_cost (p_user_id IN VARCHAR2)
      RETURN VARCHAR2;
END xxnao_noetix_vsat_security_pkg;
/


CREATE OR REPLACE PACKAGE BODY APPS.xxnao_noetix_vsat_security_pkg
IS
   FUNCTION mask_rate (p_user_name IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_count        NUMBER := 0;
      v_check_user   VARCHAR2 (1) := 'N';

      CURSOR c_lt_user
      IS
         SELECT 'Y'
           FROM sys.session_context sc, po.po_agents ag
          WHERE sc.attribute = 'EMPLOYEE_ID' AND sc.VALUE = ag.agent_id
         UNION
         SELECT 'Y'
           FROM applsys.fnd_lookup_values
          WHERE     lookup_type = 'VSAT_PO_CWK_RATE_VIEW'
                AND enabled_flag = 'Y'
                AND lookup_code = p_user_name;
   BEGIN
      FOR c_lt_user_rec IN c_lt_user
      LOOP
         v_count := v_count + 1;
      END LOOP;

      IF v_count = 0
      THEN
         v_check_user := 'N';
      ELSE
         v_check_user := 'Y';
      END IF;

      RETURN v_check_user;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_check_user := 'N';
         RETURN v_check_user;
   END mask_rate;

   FUNCTION view_cost (p_user_id IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_view_cost      VARCHAR2 (1) := 'N';
      v_view_project   VARCHAR2 (1) := 'N';
      v_update_project   VARCHAR2 (1) := 'N';
   BEGIN
      v_view_project :=
         xxnao_noetix_vsat_security_pkg.view_project (fnd_global.user_name);
         
      v_update_project :=
         xxnao_noetix_vsat_security_pkg.update_project (fnd_global.user_name);   

      IF (v_view_project = 'Y' and v_update_project='Y')
      THEN
         v_view_cost := 'Y';
      ELSIF (v_view_project = 'Y' and v_update_project='N')
      THEN
         v_view_cost := 'N';   
      ELSE
         SELECT rt.query_labor_cost_flag
           INTO v_view_cost
           FROM sys.session_context sc,
                pa.pa_project_parties km,
                pa_project_role_types rt,
                applsys.fnd_user u
          WHERE     sc.attribute = 'EMPLOYEE_ID'
                AND sc.VALUE = km.resource_source_id
                AND rt.project_role_id = km.project_role_id
                AND u.employee_id = km.resource_source_id
                AND u.user_id = p_user_id;
      END IF;

      RETURN v_view_cost;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_view_cost := 'N';
         RETURN v_view_cost;
   END view_cost;



   FUNCTION mask_account (p_user_name IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_count        NUMBER := 0;
      v_check_user   VARCHAR2 (1) := 'N';

      CURSOR c_lt_user
      IS
         SELECT lookup_type, lookup_code, meaning
           FROM applsys.fnd_lookup_values
          WHERE     lookup_type = 'VSAT_RT_ACCT_NO_CONTROL'
                AND enabled_flag = 'Y'
                AND lookup_code = p_user_name;
   BEGIN
      FOR c_lt_user_rec IN c_lt_user
      LOOP
         v_count := v_count + 1;
      END LOOP;

      IF v_count = 0
      THEN
         v_check_user := 'N';
      ELSE
         v_check_user := 'Y';
      END IF;

      RETURN v_check_user;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_check_user := 'N';
         RETURN v_check_user;
   END mask_account;

   FUNCTION view_project (p_user_name IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_count        NUMBER := 0;
      v_check_user   VARCHAR2 (1) := 'N';
      v_prof_value   VARCHAR2 (1) := 'N';

      CURSOR c_lt_user
      IS
           SELECT DISTINCT user_name, profile_option_value
             FROM (SELECT b.user_name,
                          c.responsibility_name,
                          a.start_date,
                          a.end_date
                     FROM fnd_user_resp_groups_direct a,
                          fnd_user b,
                          fnd_responsibility_tl c
                    WHERE     a.user_id = b.user_id
                          AND a.responsibility_id = c.responsibility_id
                          AND UPPER (c.responsibility_name) LIKE '%VSAT%PROJ%') user_resp,
                  (SELECT SUBSTR (pro1.user_profile_option_name, 1, 35) profile,
                          DECODE (pov.level_id,
                                  10001, 'Site',
                                  10002, 'Application',
                                  10003, 'Resp',
                                  10004, 'User')
                             option_level,
                          DECODE (pov.level_id,
                                  10001, 'Site',
                                  10002, appl.application_short_name,
                                  10003, resp.responsibility_name,
                                  10004, u.user_name)
                             level_value,
                          NVL (pov.profile_option_value, 'Is Null')
                             profile_option_value
                     FROM fnd_profile_option_values pov,
                          fnd_responsibility_tl resp,
                          fnd_application appl,
                          fnd_user u,
                          fnd_profile_options pro,
                          fnd_profile_options_tl pro1
                    WHERE pro.profile_option_name = pro1.profile_option_name
                          AND pro.profile_option_id = pov.profile_option_id
                          AND UPPER (
                                 SUBSTR (pro1.user_profile_option_name, 1, 35)) LIKE
                                 '%CROSS PROJECT USER%VIEW%'
                          AND pov.level_id = 10003
                          AND pov.level_value = resp.responsibility_id(+)
                          AND pov.level_value = appl.application_id(+)
                          AND pov.level_value = u.user_id(+)) prof_value
            WHERE user_resp.responsibility_name = prof_value.level_value
                  AND user_name = p_user_name
         ORDER BY 2 ASC;
   BEGIN
      FOR c_lt_user_rec IN c_lt_user
      LOOP
         v_prof_value := c_lt_user_rec.profile_option_value;
      END LOOP;

      IF v_prof_value <> 'Y'
      THEN
         v_check_user := 'N';
      ELSE
         v_check_user := 'Y';
      END IF;

      RETURN v_check_user;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_check_user := 'N';
         RETURN v_check_user;
   END view_project;

FUNCTION update_project (p_user_name IN VARCHAR2)
      RETURN VARCHAR2
   IS
      v_count        NUMBER := 0;
      v_check_user   VARCHAR2 (1) := 'N';
      v_prof_value   VARCHAR2 (1) := 'N';

      CURSOR c_lt_user
      IS
           SELECT DISTINCT user_name, profile_option_value
             FROM (SELECT b.user_name,
                          c.responsibility_name,
                          a.start_date,
                          a.end_date
                     FROM fnd_user_resp_groups_direct a,
                          fnd_user b,
                          fnd_responsibility_tl c
                    WHERE     a.user_id = b.user_id
                          AND a.responsibility_id = c.responsibility_id
                          AND UPPER (c.responsibility_name) LIKE '%VSAT%PROJ%') user_resp,
                  (SELECT SUBSTR (pro1.user_profile_option_name, 1, 35) profile,
                          DECODE (pov.level_id,
                                  10001, 'Site',
                                  10002, 'Application',
                                  10003, 'Resp',
                                  10004, 'User')
                             option_level,
                          DECODE (pov.level_id,
                                  10001, 'Site',
                                  10002, appl.application_short_name,
                                  10003, resp.responsibility_name,
                                  10004, u.user_name)
                             level_value,
                          NVL (pov.profile_option_value, 'Is Null')
                             profile_option_value
                     FROM fnd_profile_option_values pov,
                          fnd_responsibility_tl resp,
                          fnd_application appl,
                          fnd_user u,
                          fnd_profile_options pro,
                          fnd_profile_options_tl pro1
                    WHERE pro.profile_option_name = pro1.profile_option_name
                          AND pro.profile_option_id = pov.profile_option_id
                          AND UPPER (
                                 SUBSTR (pro1.user_profile_option_name, 1, 35)) LIKE
                                 '%CROSS PROJECT USER%UPDATE%'
                          AND pov.level_id = 10003
                          AND pov.level_value = resp.responsibility_id(+)
                          AND pov.level_value = appl.application_id(+)
                          AND pov.level_value = u.user_id(+)) prof_value
            WHERE user_resp.responsibility_name = prof_value.level_value
                  AND user_name = p_user_name
         ORDER BY 2 ASC;
   BEGIN
      FOR c_lt_user_rec IN c_lt_user
      LOOP
         v_prof_value := c_lt_user_rec.profile_option_value;
      END LOOP;

      IF v_prof_value <> 'Y'
      THEN
         v_check_user := 'N';
      ELSE
         v_check_user := 'Y';
      END IF;

      RETURN v_check_user;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_check_user := 'N';
         RETURN v_check_user;
   END update_project;

END xxnao_noetix_vsat_security_pkg;
/
