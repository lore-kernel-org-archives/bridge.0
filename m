Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=aY6EYaegNeZcRsm3y6Fc/tP8DJiXWZJIyRTKtd4cdOY=;
	b=JX0+XLqvhhWwVNTSgLUt+U4eE0m6e2mXHAUy3HfntwvD5/OKXPWzF8iv+b/aLzKwV6
	nQUVRpKHMScYLWs/xrEptfreJXn0kPvyjh6KthqiaLKubSpOwcy8cjI0oBmz+OSRXe12
	7MQFbyfdhSjoKWhX/bpnEYFEY5GuNntiSS9eE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 29 Oct 2019 13:45:52 +0200
Message-Id: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/7] net: bridge: convert fdbs to use
	bitops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
We'd like to have a well-defined behaviour when changing fdb flags. The
problem is that we've added new fields which are changed from all
contexts without any locking. We are aware of the bit test/change races
and these are fine (we can remove them later), but it is considered
undefined behaviour to change bitfields from multiple threads and also
on some architectures that can result in unexpected results,
specifically when all fields between the changed ones are also
bitfields. The conversion to bitops shows the intent clearly and
makes them use functions with well-defined behaviour in such cases.
There is no overhead for the fast-path, the bit changing functions are
used only in special cases when learning and in the slow path.
In addition this conversion allows us to simplify fdb flag handling and
avoid bugs for future bits (e.g. a forgetting to clear the new bit when
allocating a new fdb). All bridge selftests passed, also tried all of the
converted bits manually in a VM.

Thanks,
 Nik

Nikolay Aleksandrov (7):
  net: bridge: fdb: convert is_local to bitops
  net: bridge: fdb: convert is_static to bitops
  net: bridge: fdb: convert is_sticky to bitops
  net: bridge: fdb: convert added_by_user to bitops
  net: bridge: fdb: convert added_by_external_learn to use bitops
  net: bridge: fdb: convert offloaded to use bitops
  net: bridge: fdb: set flags directly in fdb_create

 net/bridge/br_fdb.c       | 133 +++++++++++++++++++-------------------
 net/bridge/br_input.c     |   2 +-
 net/bridge/br_private.h   |  17 +++--
 net/bridge/br_switchdev.c |  12 ++--
 4 files changed, 85 insertions(+), 79 deletions(-)

-- 
2.21.0

