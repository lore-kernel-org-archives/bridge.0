Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 31 Jul 2015 15:57:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150731135728.GG6366@odroid>
References: <CAJkjprMLMZXqPuAEX3Hi46Wsu1QxUuPjK-mK_M9CHPsUFvv3nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJkjprMLMZXqPuAEX3Hi46Wsu1QxUuPjK-mK_M9CHPsUFvv3nA@mail.gmail.com>
Subject: Re: [Bridge] Multicast packets are not bridged from ethernet to
 wireless interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: saurav barik <saurav.barik@gmail.com>
Cc: bridge@lists.linux-foundation.org

Hi Saurav,

On Fri, Jul 31, 2015 at 03:50:35PM +0530, saurav barik wrote:
> I am working on an Access Point device (AP1) running linux kernel 3.0.34 on
> which my bridge configuration is as follows.

There were quite some crucial bugs, I'm not quite sure whether
3.0.34 was actually usuable for multicast snooping.

Any chance to try a recent kernel?

Cheers, Linus
