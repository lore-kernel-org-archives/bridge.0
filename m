From: Bill Nottingham <notting@redhat.com>
Date: Mon,  7 Jul 2008 16:05:02 -0400
Message-Id: <cover.1215460681.git.notting@redhat.com>
Subject: [Bridge] [RFC PATCH 0/2] Allow full bridge configuration via sysfs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Right now, you can configure most bridge device parameters via sysfs.
However, you cannot either:
- add or remove bridge interfaces
- add or remove physical interfaces from a bridge

The attached patch set rectifies this. With this patch set, brctl
(theoretically) becomes completely optional, much like ifenslave is
now for bonding. (In fact, the idea for this patch, and the syntax
used herein, is inspired by the sysfs bonding configuration.)

Patchset is against net-next-2.6, but should apply to anything reasonably
recent with minimal fuzz.

Bill Nottingham (2):
  Add a 'bridging_masters' file in sysfs under class/net
  Add a 'interfaces' file to the bridge device configuration in sysfs

 net/bridge/br.c          |    2 +
 net/bridge/br_private.h  |    4 ++
 net/bridge/br_sysfs_br.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 0 deletions(-)

