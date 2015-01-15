Return-Path: <davem@davemloft.net>
Date: Thu, 15 Jan 2015 18:19:08 -0500 (EST)
Message-Id: <20150115.181908.1075649419660019957.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1421257932-11073-2-git-send-email-f.fainelli@gmail.com>
References: <1421257932-11073-1-git-send-email-f.fainelli@gmail.com>
	<1421257932-11073-2-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: ipv4: handle DSA enabled
 master network devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kaber@trash.net, buytenh@wantstofly.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 14 Jan 2015 09:52:11 -0800

> -	/* bring loopback device up first */
> +	/* bring loopback an DSA master network devices up first */

Typo: "an" should be "and"

> -		if (dev != ic_dev) {
> +		/* Only bring down unused devices and not DSA enabled master
> +		 * devices
> +		 */
> +		if (dev != ic_dev && !netdev_uses_dsa(dev)) {

You don't have to add a comment which just reads the code, I'm
a programmer so I am able to do that all on my own :-)
