Return-Path: <jhs@mojatatu.com>
Message-ID: <5164387D.8080700@mojatatu.com>
Date: Tue, 09 Apr 2013 11:49:17 -0400
From: Jamal Hadi Salim <jhs@mojatatu.com>
MIME-Version: 1.0
References: <1365442863-32394-1-git-send-email-antonio@open-mesh.com>
	<1365442863-32394-2-git-send-email-antonio@open-mesh.com>
	<CAOaVG17nHuoRsf2Kss6LnpgC-Aojcso_zLYyBa18Vn9CGGY+GA@mail.gmail.com>
	<20130409075606.GB3771@open-mesh.com>
	<51641049.3030100@mojatatu.com>
	<20130409135143.GA5177@open-mesh.com>
In-Reply-To: <20130409135143.GA5177@open-mesh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] if.h: add IFF_BRIDGE_RESTRICTED flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Antonio Quartulli <antonio@open-mesh.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On 13-04-09 09:51 AM, Antonio Quartulli wrote:

>
> Does this work at the bridge level? A packet entering a port and going out from
> another one can be affected by tc/mark?

Yes of course. And on any construct that looks like a netdev (tunnels etc).

cheers,
jamal

