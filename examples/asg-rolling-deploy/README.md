## A manual test harness
You can use this example code while working on the asg-rolling-deploy module
to repeatedly deploy and undeploy it by manually running terraform apply
and terraform destroy to check that it works as you expect.
## An automated test harness
As you will see in Chapter 9, this example code is also how you create automated
tests for your modules. I typically recommend that tests go into the test folder.
## Executable documentation
If you commit this example (including README.md) into version control, other
members of your team can find it, use it to understand how your module works,
and take the module for a spin without writing a line of code. It’s both a way to
teach the rest of your team and, if you add automated tests around it, a way to
ensure that your teaching materials always work as expected.