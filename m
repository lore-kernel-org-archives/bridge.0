Return-Path: <tyhicks@canonical.com>
From: Tyler Hicks <tyhicks@canonical.com>
Date: Fri, 13 Jul 2018 16:05:42 +0000
Message-Id: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
Subject: [Bridge] [PATCH v2 net-next 0/7] Make /sys/class/net per net
	namespace objects belong to container
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

This is a revival of an older patch set from Dmitry Torokhov:

 https://lore.kernel.org/lkml/1471386795-32918-1-git-send-email-dmitry.torokhov@gmail.com/

Here's Dmitry's description:

 There are objects in /sys hierarchy (/sys/class/net/) that logically
 belong to a namespace/container. Unfortunately all sysfs objects start
 their life belonging to global root, and while we could change
 ownership manually, keeping tracks of all objects that come and go is
 cumbersome. It would be better if kernel created them using correct
 uid/gid from the beginning. 

 This series changes kernfs to allow creating object's with arbitrary
 uid/gid, adds get_ownership() callback to ktype structure so subsystems
 could supply their own logic (likely tied to namespace support) for
 determining ownership of kobjects, and adjusts sysfs code to make use
 of this information. Lastly net-sysfs is adjusted to make sure that
 objects in net namespace are owned by the root user from the owning
 user namespace.

 Note that we do not adjust ownership of objects moved into a new
 namespace (as when moving a network device into a container) as
 userspace can easily do it.

I'm reviving this patch set because we would like this feature for
system containers. One specific use case that we have is that libvirt is
unable to configure its bridge device inside of a system container due
to the bridge files in /sys/class/net/ being owned by init root instead
of container root. The last two patches in this set are patches that
I've added to Dmitry's original set to allow such configuration of the
bridge device.

Eric had previously provided feedback that he didn't favor these changes
affecting all layers of the stack and that most of the changes could
remain local to drivers/base/core.c. That feedback is certainly sensible
but I wanted to send out v2 of the patch set without making that large
of a change since quite a bit of time has passed and the bridge changes
in the last patch of this set shows that not all of the changes will be
local to drivers/base/core.c. I'm happy to make the changes if the
original request still stands.

I've verified that all of the bridge related files affected by patch 7
have proper access control checks for CAP_NET_ADMIN inside of the
user namespace. I have *not* yet verified that all of the network
device related sysfs files affected by patch 5 have proper access
control checks. I was working under the assumption that those code paths
already were verified when the first iteration of the patches were sent
out.

* Changes since v1:
  - Patch 1 was forward ported to use idr instead of ida for the inode
    num
  - Patch 5 was forward ported around the ro_after_init changes
  - Patch 5 received a build failure fix for !CONFIG_SYSFS
  - Patch 6 and 7 are new

Thanks!

Tyler

