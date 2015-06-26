Return-Path: <jmadom@televes.com>
Message-ID: <558D3FD9.60007@televes.com>
Date: Fri, 26 Jun 2015 14:04:41 +0200
From: Jorge Dominguez <jmadom@televes.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------080004040700060108030904"
Subject: [Bridge] unregister_netdevice: waiting for br0 to become free.
 Usage count = 1 (2.6.12.3)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------080004040700060108030904
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This mail list provides me a lot of information about problem and I want share solution to bad refcount on bridge.

Solution is applied on kernel

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f3abc9b963e004b8c96cd7fbee6fd905f2bfd620

commit f216f082b2b37c4943f1e7c393e2786648d48f6f
([NETFILTER]: bridge netfilter: deal with martians correctly)
added a refcount leak on in_dev.

Instead of using in_dev_get(), we can use __in_dev_get_rcu(),
as netfilter hooks are running under rcu_read_lock(), as pointed
by Patrick.


diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 4fde742..907a82e 100644
--- a/net/bridge/br_netfilter.c 
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/bridge/br_netfilter.c?id=cce5a5c3029f731b5ea17a8a9a953ff742abf0d6>
+++ b/net/bridge/br_netfilter.c 
<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/bridge/br_netfilter.c?id=f3abc9b963e004b8c96cd7fbee6fd905f2bfd620>
@@ -359,7 +359,7 @@ static int br_nf_pre_routing_finish(struct sk_buff *skb)
},
.proto = 0,
};
- struct in_device *in_dev = in_dev_get(dev);
+ struct in_device *in_dev = __in_dev_get_rcu(dev);

Best Regards,
Jorge.



>/  Two other recent reports are:
/>/  1. Buggy applications that hold packets in their input queue forever,
/>/     and/or netfilters.  The socket buffer's contain a reference for
/>/     packets in flight.
/
that may be it, but I am not sure which queue you are talking about,
but there is an application that is using the netfiler ip_queue to
queue packets to user space.  in this application, these packets can
be held in user space for extended periods of time (up to 30/60
seconds), and then they are either dropped or released.  Could this
possibly be creating a problem?

I don't believe that the system is using any of the VLAN code.

>/  I have found an appearant leak of a route object, which holds a
/>/  reference
/>/  to a device.  I reproduced in both 2.6.11 and 2.6.13 using 802.1Q
/>/  VLANs.
/>/  I have a patch that will print out the place of the leaked reference
/>/  against 2.6.13.
/>/
/>/  http://www.candelatech.com/oss/rfcnt.patch
/>/
/>/  Enable the feature in the Networking section of Kconfig.
/Ben, i will incorporate this patch and let you know if i turn up any
results.

thanks,
--robert

On Aug 31, 2005, at 9:37 PM, Stephen Hemminger wrote:

>/  On Wed, 31 Aug 2005 19:04:01 -0700
/>/  Robert Scott <rbscott at axentra.net  <https://lists.linux-foundation.org/mailman/listinfo/bridge>> wrote:
/>/
/>/
/>>/  Hello,
/>>/
/>>/  I know that this bug has been discussed before at length on this
/>>/  mailing list, but previous post seemed to indicate that it was fixed
/>>/  before kernel 2.6.12.  I am still seeing this occasionally in kernel
/>>/  2.6.12.3.  The system is running knoppix, and IPV6 is not compiled
/>>/  into the kernel(other posts mentioned numerous problems with the IPV6
/>>/  code).  But every so often, when bringing down the bridge (it doesn't
/>>/  happen every time), the process hangs, and the following message
/>>/  appears in dmesg repeatedly:
/>>/
/>>/  'unregister_netdevice: waiting for br0 to become free. Usage count
/>>/  = 1'
/>>/
/>>/  None of the processes involved can be killed, and an attempt to run
/>>/  an ifconfig results in a process that is also waiting forever.  At
/>>/  this point the box must be rebooted forcefully.
/>>/
/>>/  Two questions.
/>>/  1. In a previous post, someone mentioned one solution was to
/>>/  commenting out the check that is hanging in the kernel.   Does this
/>>/  check preventing something terrible from happening(i assumed that it
/>>/  does), or is it safe to remove it
/>>/
/>/
/>/  Really bad idea, because if the thing that is holding the reference
/>/  like packets stuck in some dead queue, ever get processed the kernel
/>/  will die.
/>/
/>/
/>>/  2. Any ideas of something to try in order to make this repeatable?
/>>/
/>/
/>/  Two other recent reports are:
/>/  1. Buggy applications that hold packets in their input queue forever,
/>/     and/or netfilters.  The socket buffer's contain a reference for
/>/     packets in flight.
/>/
/>/  2. The VLAN code had a number of reference bugs, if you look through
/>/     recent netdev mailing list you will see the discussion.
/>/
/


--------------080004040700060108030904
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <pre>Hi, 

This mail list provides me a lot of information about problem and I want share solution to bad refcount on bridge. 

Solution is applied on kernel 

<a class="moz-txt-link-freetext" href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f3abc9b963e004b8c96cd7fbee6fd905f2bfd620">https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f3abc9b963e004b8c96cd7fbee6fd905f2bfd620</a>

commit f216f082b2b37c4943f1e7c393e2786648d48f6f
([NETFILTER]: bridge netfilter: deal with martians correctly)
added a refcount leak on in_dev.

Instead of using in_dev_get(), we can use __in_dev_get_rcu(),
as netfilter hooks are running under rcu_read_lock(), as pointed
by Patrick.


</pre>
    <div class="head">diff --git a/net/bridge/br_netfilter.c
      b/net/bridge/br_netfilter.c<br>
      index 4fde742..907a82e 100644<br>
      --- a/<a
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/bridge/br_netfilter.c?id=cce5a5c3029f731b5ea17a8a9a953ff742abf0d6">net/bridge/br_netfilter.c</a><br>
      +++ b/<a
href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/bridge/br_netfilter.c?id=f3abc9b963e004b8c96cd7fbee6fd905f2bfd620">net/bridge/br_netfilter.c</a></div>
    <div class="hunk">@@ -359,7 +359,7 @@ static int
      br_nf_pre_routing_finish(struct sk_buff *skb)</div>
    <div class="ctx"> },</div>
    <div class="ctx"> .proto = 0,</div>
    <div class="ctx"> };</div>
    <div class="del">- struct in_device *in_dev = in_dev_get(dev);</div>
    <div class="add">+ struct in_device *in_dev = __in_dev_get_rcu(dev);<br>
      <br>
      Best Regards,<br>
      Jorge.<br>
    </div>
    <pre>


&gt;<i> Two other recent reports are:
</i>&gt;<i> 1. Buggy applications that hold packets in their input queue forever,
</i>&gt;<i>    and/or netfilters.  The socket buffer's contain a reference for
</i>&gt;<i>    packets in flight.
</i>
that may be it, but I am not sure which queue you are talking about,  
but there is an application that is using the netfiler ip_queue to  
queue packets to user space.  in this application, these packets can  
be held in user space for extended periods of time (up to 30/60  
seconds), and then they are either dropped or released.  Could this  
possibly be creating a problem?

I don't believe that the system is using any of the VLAN code.

&gt;<i> I have found an appearant leak of a route object, which holds a  
</i>&gt;<i> reference
</i>&gt;<i> to a device.  I reproduced in both 2.6.11 and 2.6.13 using 802.1Q  
</i>&gt;<i> VLANs.
</i>&gt;<i> I have a patch that will print out the place of the leaked reference
</i>&gt;<i> against 2.6.13.
</i>&gt;<i>
</i>&gt;<i> <a href="http://www.candelatech.com/oss/rfcnt.patch">http://www.candelatech.com/oss/rfcnt.patch</a>
</i>&gt;<i>
</i>&gt;<i> Enable the feature in the Networking section of Kconfig.
</i>Ben, i will incorporate this patch and let you know if i turn up any  
results.

thanks,
--robert

On Aug 31, 2005, at 9:37 PM, Stephen Hemminger wrote:

&gt;<i> On Wed, 31 Aug 2005 19:04:01 -0700
</i>&gt;<i> Robert Scott &lt;<a href="https://lists.linux-foundation.org/mailman/listinfo/bridge">rbscott at axentra.net</a>&gt; wrote:
</i>&gt;<i>
</i>&gt;<i>
</i>&gt;&gt;<i> Hello,
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> I know that this bug has been discussed before at length on this
</i>&gt;&gt;<i> mailing list, but previous post seemed to indicate that it was fixed
</i>&gt;&gt;<i> before kernel 2.6.12.  I am still seeing this occasionally in kernel
</i>&gt;&gt;<i> 2.6.12.3.  The system is running knoppix, and IPV6 is not compiled
</i>&gt;&gt;<i> into the kernel(other posts mentioned numerous problems with the IPV6
</i>&gt;&gt;<i> code).  But every so often, when bringing down the bridge (it doesn't
</i>&gt;&gt;<i> happen every time), the process hangs, and the following message
</i>&gt;&gt;<i> appears in dmesg repeatedly:
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> 'unregister_netdevice: waiting for br0 to become free. Usage count  
</i>&gt;&gt;<i> = 1'
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> None of the processes involved can be killed, and an attempt to run
</i>&gt;&gt;<i> an ifconfig results in a process that is also waiting forever.  At
</i>&gt;&gt;<i> this point the box must be rebooted forcefully.
</i>&gt;&gt;<i>
</i>&gt;&gt;<i> Two questions.
</i>&gt;&gt;<i> 1. In a previous post, someone mentioned one solution was to
</i>&gt;&gt;<i> commenting out the check that is hanging in the kernel.   Does this
</i>&gt;&gt;<i> check preventing something terrible from happening(i assumed that it
</i>&gt;&gt;<i> does), or is it safe to remove it
</i>&gt;&gt;<i>
</i>&gt;<i>
</i>&gt;<i> Really bad idea, because if the thing that is holding the reference
</i>&gt;<i> like packets stuck in some dead queue, ever get processed the kernel
</i>&gt;<i> will die.
</i>&gt;<i>
</i>&gt;<i>
</i>&gt;&gt;<i> 2. Any ideas of something to try in order to make this repeatable?
</i>&gt;&gt;<i>
</i>&gt;<i>
</i>&gt;<i> Two other recent reports are:
</i>&gt;<i> 1. Buggy applications that hold packets in their input queue forever,
</i>&gt;<i>    and/or netfilters.  The socket buffer's contain a reference for
</i>&gt;<i>    packets in flight.
</i>&gt;<i>
</i>&gt;<i> 2. The VLAN code had a number of reference bugs, if you look through
</i>&gt;<i>    recent netdev mailing list you will see the discussion.
</i>&gt;<i>
</i>
</pre>
  </body>
</html>

--------------080004040700060108030904--
