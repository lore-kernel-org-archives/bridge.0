Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Cpo9iaS4cwUeT49Upjnb/d5CGNlsHCO0WI9NlfpnN1k=;
	b=SG/8kU+Lm/2blrix2IvG0cV/b6wOtDkm8zyw2616BnDCO5L9Cxi5ABZphRXaKRYi45gYi77PnnBsCA2ziMzIQvtUqtcg9+1cjNeUbMEm+2mFJFmsOXOQQEmKCXwWlPUzgKcZFK7+lOXXXPRluGE32FGAHTO0KC3cbYvjc3kExis=
From: Petr Machata <petrm@mellanox.com>
References: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
	<58a3153f-9393-da8c-7aea-7a68537f6f90@cumulusnetworks.com>
	<012aee15-9e57-0267-cc3a-3b091977fa3f@cumulusnetworks.com>
Date: Mon, 28 May 2018 19:19:43 +0300
In-Reply-To: <012aee15-9e57-0267-cc3a-3b091977fa3f@cumulusnetworks.com>
	(Nikolay Aleksandrov's message of "Mon, 28 May 2018 18:53:58 +0300")
Message-ID: <wihfu2bg3c0.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Lock before br_fdb_find()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:

> Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")

Correct.

Thanks,
Petr
