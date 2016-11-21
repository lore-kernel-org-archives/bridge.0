Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=6x4KGSWVgLyAopZmubagKwxnsX3GEf9M1WRQY6Gtxlk=;
	b=l0cM9CLPlIT6+Wmpwv8hIiJw/4orR+B5s2DqsoMQvTFnFM90xZGXZseFwQFRX9gwUz
	1xTqItGc3m5Hh31Ja0cjNLxuLjUGrtR0iIdXVaYKhQTJLE7zTJYKaUYoe3AKGl1MfOD2
	E1MdJn+FG1uYbypv+iqdxPXfhntlpPJHZsnGvKkWP/idxGufU2I3I5L+1IBmU+/Al81J
	G1y/sZvBmSopT7UIa4OA621mASGVFzbLxWajlmfm1ITxrnoWYk75vKKWQmT3nbBzvjFz
	8v3qCboLXn+b1YZ0B6e+O5IkPy4hispL91aCqIxF05A6Nlf8KIdBALN8rk8EOiGhG2D7
	rWVQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 21 Nov 2016 11:09:22 -0800
Message-Id: <20161121190925.14530-1-f.fainelli@gmail.com>
Subject: [Bridge] [RFC net-next 0/3] net: bridge: Allow CPU port
	configuration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: idosch@mellanox.com, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@savoirfairelinux.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, davem@davemloft.net

Hi all,

This patch series allows using the bridge master interface to configure
an Ethernet switch port's CPU/management port with different VLAN attributes than
those of the bridge downstream ports/members.

Jiri, Ido, Andrew, Vivien, please review the impact on mlxsw and mv88e6xxx, I
tested this with b53 and a mockup DSA driver.

Open questions:

- if we have more than one bridge on top of a physical switch, the driver
  should keep track of that and verify that we are not going to change
  the CPU port VLAN attributes in a way that results in incompatible settings
  to be applied

- if the default behavior is to have all VLANs associated with the CPU port
  be ingressing/egressing tagged to the CPU, is this really useful?

Florian Fainelli (3):
  net: bridge: Allow bridge master device to configure switch CPU port
  net: dsa: Propagate VLAN add/del to CPU port(s)
  net: dsa: b53: Remove CPU port specific VLAN programming

 drivers/net/dsa/b53/b53_common.c | 22 ++++++--------------
 net/bridge/br_vlan.c             | 28 ++++++++++++++++++++++---
 net/dsa/slave.c                  | 45 +++++++++++++++++++++++++++++-----------
 3 files changed, 64 insertions(+), 31 deletions(-)

-- 
2.9.3

