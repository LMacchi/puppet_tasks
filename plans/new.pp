plan my_tasks::new (
  TargetSpec  $masters,
  TargetSpec  $agents,
) {

  run_task('my_tasks::test', $masters)
  run_task('mymodule::another_test', $agents)
}       
