Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=12EqEO1pUajfNa5Vuwtz/ov75RU/0klWFXkN7c4vySE=;
	b=Fb80bpsaLH71Zq7y0UG2APa8de2AYK5bNnyiE9pO4i0A92LecK+0vYLbXS2SR+aafS
	j1RfLJF3FWGmdMTdAZMkl6HUMQ0ICG2ncBCdLOpFKDRMz7lUsWk01L9RD67lIkUG/er8
	lTdm2w2iePBo98ElUcjP6IkgxJrheubDsEE7fFxrU9w2/qK8i+BaylrZ/jOTxJhNvgvp
	AGGMjS5DJXZ5kOOV4hDDMCFkYgvLinXG0CPAQOPToi5mphDt2VM7yPRR6k0Iy6L8LYcB
	VgYtKl/dVlegvdNOwd72CEjqt53UdICUzFJ5SAtg9Ky64lMsBDtLkupaHXx8Krb7o52u
	hhyQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 16 Jan 2015 09:56:00 -0800
Message-Id: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 0/2] net: DSA fixes for bridge and
	ip-autoconf
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, kaber@trash.net, davem@davemloft.net, buytenh@wantstofly.org

Hi David,

These two patches address some real world use cases of the DSA master and slave
network devices.

You have already seen patch 1 previously and you rejected it since my
explanations were not good enough to provide a justification as to why it is
useful, hopefully this time my explanation is better.

Patch 2 solves a different, yet very real problem as well at the bridge layer
when using DSA network devices.

Florian Fainelli (2):
  net: ipv4: handle DSA enabled master network devices
  net: bridge: reject DSA-enabled master netdevices as bridge members

 net/bridge/br_if.c  | 10 ++++++++--
 net/ipv4/ipconfig.c |  6 +++---
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.1.0

