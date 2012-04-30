update melete_module set modify_user_id = user_id where modify_user_id is NULL OR modify_user_id = '';

update melete_section, melete_module set melete_section.user_id = melete_module.user_id, melete_section.modify_user_id = melete_module.user_id where melete_section.module_id = melete_module.module_id and (melete_section.user_id is NULL OR melete_section.user_id = '');

