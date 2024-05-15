select
	--INC.BaseManagedEntityId                                               as [PK]
	INC.Id_9A505725_E2F2_447F_271B_9B9F4F0D190C                           as [ID]
	, AffectedUser.DisplayName                                              as [AffectedName]
	, AffectedUser.UserName_6AF77E23_669B_123F_B392_323C17097BBD            as [AffectedUserName]
	, AffectedUser.Company_8CD345AC_E9BC_E5FE_88BA_D281FC29637D             as [Company]
	, AssignedToUser.DisplayName                                            as [AssignedToName]
	, AssignedToUser.UserName_6AF77E23_669B_123F_B392_323C17097BBD          as [AssignedToUserName]
	, INC.Title_9691DD10_7211_C835_E3E7_6B38AF8B8104                        as [Title]
	--, INC.DisplayName                                                       as [Displayname] --ID and Title
	, INC.CreatedDate_6258638D_B885_AB3C_E316_D00782B8F688                  as [CreatedDate]
	, INC.ResolvedDate_D2A4C73F_01B8_29C5_895B_5BE4C3DFAC4E                 as [ResolvedData]
	, INC.ClosedDate_C529833E_0926_F082_C185_294CBC8BB9FD                   as [ClosedDate]
	, INC.Description_59B77FD5_FE0E_D2B5_D541_0EBBD1EC9A2B                  as [Description]
	, INC.ResolutionDescription_85E8B5FA_3ECB_9B6C_0A02_A8C9EC085A39        as [ResolutionDescription]
	, Status.LTValue                                                        as [Status]
	, Classification.LTValue                                                as [Classification]
from MTV_System$WorkItem$Incident as INC

	/*Get Affected User*/
left outer Join
	(
	select
		rel1.SourceEntityId
		, Users.DisplayName
		, Users.UserName_6AF77E23_669B_123F_B392_323C17097BBD
		, Users.Company_8CD345AC_E9BC_E5FE_88BA_D281FC29637D
	from
		MTV_System$Domain$User as Users
	inner join
		Relationship as rel1 on Users.BaseManagedEntityID=Rel1.TargetEntityId
		where
			rel1.RelationshipTypeId= 'DFF9BE66-38B0-B6D6-6144-A412A3EBD4CE'
			and rel1.IsDeleted     = '0'
	)
	as AffectedUser
	on affectedUser.SourceEntityId=INC.BaseManagedEntityId

	/*Get Assigned To User*/
left outer Join
	(
	select
		rel1.SourceEntityId
		, Users.DisplayName
		, Users.UserName_6AF77E23_669B_123F_B392_323C17097BBD
	from
		MTV_System$Domain$User as Users
	inner join
		Relationship as rel1 on Users.BaseManagedEntityID=Rel1.TargetEntityId
		where
			rel1.RelationshipTypeId= '15E577A3-6BF9-6713-4EAC-BA5A5B7C4722'
			and rel1.IsDeleted     = '0'
	)
	as AssignedToUser
	on AssignedToUser.SourceEntityId=INC.BaseManagedEntityId

	/*Classification*/
	left outer join
		( select * from LocalizedText where (LanguageCode = 'ENU') AND (LTStringType = '1') )
			as Classification
			on Classification.LTStringId = INC.Classification_00B528BF_FB8F_2ED4_2434_5DF2966EA5FA

	/*Status*/
	left outer join
		( select * from LocalizedText where (LanguageCode = 'ENU') AND (LTStringType = '1') )
			as Status
			on Status.LTStringId = INC.Status_785407A9_729D_3A74_A383_575DB0CD50ED
