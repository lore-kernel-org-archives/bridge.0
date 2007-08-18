DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	b=CW33Ci5p0HHYlXnIZC94t9++wIM++z15n/j/bl9tOA03nR7KyeMg2cJicHqCRtSf62SL6QTMwmzs0GiZkMje135X5mbUFe1lelgy58XOzRwZFt79St7hxDNW3V5bHkBw4orCQhfxaHJKfZ/Ak5CUC6KuITZL6C9Tkjlv246okpM=
Message-ID: <fed120860708180121l329fe20bj8da9d0ef9f636b08@mail.gmail.com>
Date: Sat, 18 Aug 2007 13:51:04 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Subject: Re: [Bridge] Re: Reset of setpathcost after link comes back up
In-Reply-To: <20070817154247.56a793f4@freepuppy.rosehill.hemminger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <58e46d120708150127o6cc0b487x1b6563016cb4716a@mail.gmail.com>
	<20070817154247.56a793f4@freepuppy.rosehill.hemminger.net>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, Vassil Panayotov <vassil.panayotov@gmail.com>

>
> > IMO this is the desired behaviour - the port path cost is recalculated
> > every time when link state change is detected, probably to accommodate
> > to possible link speed change.
>
> Yup.
>

I think that if the port path cost has been adminstratively set, it
should not be recalculated when the link speed changes. There is a
patch in the February archives which is supposed to fix this, but it
doesn't seem to have made it upstream yet.

The patch:
[Bridge] [PATCH 3/4] bridge: make path cost setting persistent
https://lists.linux-foundation.org/pipermail/bridge/2007-February/005265.html
