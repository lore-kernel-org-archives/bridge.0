Return-Path: <horms@verge.net.au>
Date: Mon, 15 Dec 2014 17:04:38 +0900
From: Simon Horman <horms@verge.net.au>
Message-ID: <20141215080438.GA23985@verge.net.au>
References: <20140325125231.GW6008@Linus-Debian> <20140910133341.GI7058@odroid>
	<20141210191633.GA2473@odroid>
	<20141213.153741.1636406298389279104.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141213.153741.1636406298389279104.davem@davemloft.net>
Subject: Re: [Bridge] Multicast packets being lost (3.10 stable)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: linus.luessing@c0d3.blue, shemming@brocade.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, gregkh@linuxfoundation.org, openwrt-devel@lists.openwrt.org

On Sat, Dec 13, 2014 at 03:37:41PM -0500, David Miller wrote:
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> Date: Wed, 10 Dec 2014 20:16:33 +0100
> 
> > did you have a chance to look into backporting these fixes for
> > stable yet?
> 
> I am not submitting -stable fixes back to 3.10 any longer, at most
> I am doing 4 -stable releases and right now that is 3.18, 3.17,
> v3.14, and v3.12

Hi Dave,

is there a method for people to get networking -stable fixes into older
(longterm) stable releases? Would it be best if people submitted them to
-stable themselves?
