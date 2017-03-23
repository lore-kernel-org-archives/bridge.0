Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=1HIY27ATwupBIbMYAAzidn8eGOV+MLost0/em/IGBjo=;
	b=BmcKXjpgwklx8lu+/xEkxLCxIZKHSz4bcfL16o1KFEvTzu9yU2iJyeiLIea7AsSKD3
	QrdoD9v6aGPcL+7amM8qIvgpH+8R7WZkZG/biUteV3ziNVJ6Ibxi76SSVwYS4jqKbX2u
	8uysEwAURn5fi2457rxSv1RySqs78tIXBAW6s=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 23 Mar 2017 12:27:11 +0200
Message-Id: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: allow user-space to add
	ext learned entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

Hi,
This set adds the ability to add externally learned entries from
user-space. For symmetry and proper function we need to allow SW entries
to take over HW learned ones (similar to how HW can take over SW entries
currently) which is needed for our use case (evpn) where we have pure SW
ports and HW ports mixed in a single bridge. This does not play well with
switchdev devices currently because there's no feedback when the entry is
taken over, but this case has never worked anyway and feedback can be
easily added when needed.
Patch 02 simply allows to use NTF_EXT_LEARNED from user-space, we already
have Quagga patches that make use of this functionality.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: allow SW learn to take over HW fdb entries
  net: bridge: allow to add externally learned entries from user-space

 net/bridge/br_fdb.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.1.4

