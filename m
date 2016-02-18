Return-Path: <sesse@samfundet.no>
Date: Thu, 18 Feb 2016 13:51:34 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Message-ID: <20160218125134.GA20283@sesse.net>
References: <1455502026-23144-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1455502026-23144-1-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH] net: fix bridge multicast packet checksum
	validation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Tom Herbert <tom@herbertland.com>, "David S . Miller" <davem@davemloft.net>

On Mon, Feb 15, 2016 at 03:07:06AM +0100, Linus Lüssing wrote:
> Steinar, can you check whether this fixes the bridge issues you reported on
> bugzilla #99081? Not quite sure whether it is the same as yours as you
> do not seem to have any such call traces.

It doesn't immediately sound like the same problem; why would promisc change
anything if the problem is the checksumming?

I don't have any reboots scheduled for this machine right now, but I'll see
what I can do wrt. testing.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
