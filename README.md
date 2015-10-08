# splunk-thp-disable

## THP (Transparent Huge Pages) Disabler for splunk

Transparent Huge Pages are enabled by default in alot of linux systems. The kernel attempts to allocate hugepages whenever possible and any Linux process will receive 2MB pages if the mmap region is 2MB naturally aligned. The main kernel address space itself is mapped with hugepages, reducing TLB pressure from kernel code. For general information on Hugepages, 

see: [What are Huge Pages and what are the advantages of using them?](https://access.redhat.com/solutions/2592)

## References

* [Splunk Notes](http://docs.splunk.com/Documentation/Splunk/latest/ReleaseNotes/SplunkandTHP)
* [Redhat Notes](https://access.redhat.com/solutions/46111)
* [Oracle Notes](https://blogs.oracle.com/linux/entry/performance_issues_with_transparent_huge)
* [Splunk Answers](http://answers.splunk.com/answers/188875/how-do-i-disable-transparent-huge-pages-thp-and-co.html)

This currently just makes and RPM for RHEL based systems. It will work on RHEL7 which uses systemd. But I will updated it eventually for all Linux distros.
