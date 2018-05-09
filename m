Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=MttfFlHk8yW7phYgWpUVZq+4ZEvqWGFahu5dSt5Z0cY=;
	b=VcU332s9VDxUJ2Zgs2cM2lNEcqtRxR3F8SGCy1EFbrsh7nClmYhItUv83U8jNgPdH02TS6peHz2QGRuRTKRWVCGruQo97t0k7z3Q8horGJgmDvjHqIfk/dOZ5oZdWUNfRlF7LopP7faoi84LUul7xR5zHhAYQ8PRWcZNflfKqi0=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
	(Vivien Didelot's message of "Tue, 8 May 2018 23:03:12 -0400")
References: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
Date: Wed, 09 May 2018 11:54:06 +0300
Message-ID: <wihmux96wgh.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next] net: dsa: fix added_by_user switchdev
	notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, kernel@savoirfairelinux.com, davem@davemloft.net

Vivien Didelot <vivien.didelot@savoirfairelinux.com> writes:

> @petr I expect the same issue with Rocker, but I haven't tested it.

Yeah, pretty sure. Such an obvious bug, sorry about that :-/
I'll send a rocker patch later today.

Thanks,
Petr
