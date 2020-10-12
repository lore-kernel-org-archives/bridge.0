Return-Path: <bjorn@mork.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
 t=1602485253; bh=EM7SRTw2y1jyItrWLGnDOK3doiCpFc3aZvBKNU44DDM=;
 h=From:To:Cc:Subject:References:Date:Message-ID:From;
 b=kS4WJ5liWgVBV/PZX+XguD8kCe6CzMV/SozNJtRSLrEKROlT0lTnXLxcEgUI/lHdQ
 9tYB5Ub5nfYwmhAFrio3yOnThkWaMB2+jpHWpbr4jiJ7rdoEAKWTMxqcxuu7E30hua
 P5LK3vjH6VIkjZp2gBCjFgbQ19M2Yxa9QIgJzGaw=
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <a46f539e-a54d-7e92-0372-cd96bb280729@gmail.com>
 <9cde03fe-d032-521d-2d34-34429d6d1a1c@gmail.com>
Date: Mon, 12 Oct 2020 08:47:25 +0200
In-Reply-To: <9cde03fe-d032-521d-2d34-34429d6d1a1c@gmail.com> (Heiner
 Kallweit's message of "Sun, 11 Oct 2020 21:38:44 +0200")
Message-ID: <87imbgdjpe.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 04/12] net: usb: qmi_wwan: use new
	function dev_fetch_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Sergey Matyukevich <geomatsi@gmail.com>, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Pravin B Shelar <pshelar@ovn.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Simplify the code by using new function dev_fetch_sw_netstats().
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>
