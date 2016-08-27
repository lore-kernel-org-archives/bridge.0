Return-Path: <sergei.shtylyov@cogentembedded.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=g84fXSabTQye1AaQSUoUba2eo9xl08kCDLR/NcFQ/uY=;
	b=U6rtlcWg0IOH0IFUAcOx3kWgSs5YsJ3u+v7gq1YV/E/x1+TlbiaIcNZCfztbE2dzqi
	zW5MtyIMqFhTNH/Jedl5yXQp6e7BCzZPdQ51B70+icwFpvyh31nWe+qQt5FWUyveL7Qe
	SVxh7rmGt+qBt2yPWPnnkcZ2d/Myvg4L0KXnSiN/c1IDQnZCyTefTfp5cmfGJYgTN5Df
	Xci420852S3I65rGPvXEi1mGkr4Jx2NjGsOjEYeYHOLds/K2DNUSAniMAtpRqBq4BuGP
	aH88CNBT/45PtcY5AwlE3GvvdNpKfSTe7OZMji/dzb1IAqHIMF+oD5IDD/2YB7PsWRyv
	A7jA==
References: <1472267428-810527-1-git-send-email-green@linuxhacker.ru>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <11e50e3c-2e1f-4614-07e3-3bd144af4f94@cogentembedded.com>
Date: Sat, 27 Aug 2016 18:13:03 +0300
MIME-Version: 1.0
In-Reply-To: <1472267428-810527-1-git-send-email-green@linuxhacker.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Fix format string for %ul
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleg Drokin <green@linuxhacker.ru>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Hello.

On 8/27/2016 6:10 AM, Oleg Drokin wrote:

> %ul would print an unsigned value and a letter l,
> likely it was %lu that was meant to print the long int,
> but in reality the values printed there are just regular signed

    Signed? Then you need probably "%d" or "%i"...

> ints, so just dropping the l altogether.
>
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
[...]

MBR, Sergei

