# Used to build my master table
SELECT
  SUBSTR(_TABLE_SUFFIX, 1, 4) as year,
  SUBSTR(_TABLE_SUFFIX, 5,2) as month,
  _TABLE_SUFFIX as period,
  repo.id AS repoId,
  repo.name AS repoName,
  actor.id as userId,
  actor.login AS user,
  org.id as orgId,
  org.login AS org,
  type as event,
IF
  (type="PushEvent"
    OR type="PullRequestEvent"
    OR type="PullRequestReviewCommentEvent",
    TRUE,
    FALSE) AS codeEvent,
IF
  (type="ForkEvent"
    OR type="WatchEvent"
    OR type="IssuesEvent"
    OR type="IssueCommentEvent",
    TRUE,
    FALSE) AS popularityEvent,
IF
  (REGEXP_CONTAINS(repo.url,    r'(?i)webrtc')
    OR REGEXP_CONTAINS(payload, r'(?i)webrtc')
    OR REGEXP_CONTAINS(other,   r'(?i)webrtc'),
    TRUE,
    FALSE) AS keywordWebrtc,
IF
  (REGEXP_CONTAINS(repo.url,    r'(?i)getusermedia')
    OR REGEXP_CONTAINS(payload, r'(?i)getusermedia')
    OR REGEXP_CONTAINS(other,   r'(?i)getusermedia'),
    TRUE,
    FALSE) AS keywordGum,
IF
  (REGEXP_CONTAINS(repo.url,    r'(?i)\b(stun|turn).?server')
    OR REGEXP_CONTAINS(payload, r'(?i)\b(stun|turn).?server')
    OR REGEXP_CONTAINS(other,   r'(?i)\b(stun|turn).?server'),
    TRUE,
    FALSE) AS keywordStunTurn,
IF
  (REGEXP_CONTAINS(repo.url,    r'(?i)peerconnection')
    OR REGEXP_CONTAINS(payload, r'(?i)peerconnection')
    OR REGEXP_CONTAINS(other,   r'(?i)peerconnection'),
    TRUE,
    FALSE) AS keywordPc,
IF
  (REGEXP_CONTAINS(repo.url,    r'(?i)rtpsender|rtpreceiver|rtptransceiver|rtcdtlstransport|icetransport|rtctrackevent')
    OR REGEXP_CONTAINS(payload, r'(?i)rtpsender|rtpreceiver|rtptransceiver|rtcdtlstransport|icetransport|rtctrackevent')
    OR REGEXP_CONTAINS(other,   r'(?i)rtpsender|rtpreceiver|rtptransceiver|rtcdtlstransport|icetransport|rtctrackevent'),
    TRUE,
    FALSE) AS keywordPcExt
FROM
  `githubarchive.month.*`
WHERE
    REGEXP_CONTAINS(repo.url,   r'(?i)webrtc|getusermedia|peerconnection|rtpsender|rtpreceiver|rtptransceiver|rtcdtlstransport|icetransport|rtctrackevent|\b(stun|turn).?server')
    OR REGEXP_CONTAINS(payload, r'(?i)webrtc|getusermedia|peerconnection|rtpsender|rtpreceiver|rtptransceiver|rtcdtlstransport|icetransport|rtctrackevent|\b(stun|turn).?server')
    OR REGEXP_CONTAINS(other,   r'(?i)webrtc|getusermedia|peerconnection|rtpsender|rtpreceiver|rtptransceiver|rtcdtlstransport|icetransport|rtctrackevent|\b(stun|turn).?server') 
