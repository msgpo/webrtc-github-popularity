SELECT
  repoName,
  count (DISTINCT userId) AS all_users
 FROM
  `github_analysis_2019.webrtc_repos`
WHERE
  year = '2019'
GROUP BY
  repoName
ORDER BY
  all_users Desc
