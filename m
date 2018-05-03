Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=9BwdxptZHmO7F+AG3L8v8VW4HyQ7jNnjzqhD+x7ajJo=;
	b=aV4SI7Y/FC7XdMnejnPqBpB/Az64AsMJNnnryxyuLhCcJiLNhY6Lhs6YwDp+5c8tTMB9jtIHT43iqHh/kLX4XDaNjfrWUzDDrLTmHuCNkea3Wg+U6cz+EHrXsbKx5tRW7v0/NRqoT0c595fwIid8DmMoca9OMmff6rjVCNFTsLk=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1525350809.git.petrm@mellanox.com>
Date: Thu, 03 May 2018 15:48:05 +0300
In-Reply-To: <cover.1525350809.git.petrm@mellanox.com> (Petr Machata's message
	of "Thu, 03 May 2018 14:43:40 +0200")
Message-ID: <wih8t90sy62.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 0/2] bridge: FDB: Notify
	about removal of non-user-added entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

This is of course not meant for "mlxsw" :-/

Petr
