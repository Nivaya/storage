INSERT stdb.roles (name)
VALUES ('root'),('admin'),('guset')


/*DROP PROCEDURE history_p;*/

CREATE PROCEDURE history_p (
	IN id_in VARCHAR (30),
	IN usr_in VARCHAR (30),
	IN lc_in VARCHAR (30),
	IN ext_in VARCHAR (2),
	IN redate_in VARCHAR (30)
)
BEGIN
	UPDATE stdb. STORAGE st
SET st.username = CASE ext_in
WHEN '1' THEN
	usr_in
WHEN '0' THEN
	'仓库'
END,
 st.location = CASE ext_in
WHEN '1' THEN
	lc_in
WHEN '0' THEN
	'仓库'
END,
 st.modify_date = now(),
 st.modify_user = 'admin'
WHERE
	st.id = id_in;

INSERT stdb.st_history (
	part_id,
	username,
	location,
	state,
	create_date,
	create_user,
	register_date
)
VALUE
	(
		id_in,
		usr_in,
		lc_in,
		CASE ext_in
	WHEN '1' THEN
		'借'
	WHEN '0' THEN
		'还'
	END,
	now(),
	'admin',
	redate_in
	);


END;

