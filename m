Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X8UUPTOUNfFXETSXGA8mkvkgEObCurF5t9bY3s9/WBw=; b=CvGoJahVgWmRUJ6lVkXuQ1M419
 Q/XFzshlEk7MPbOCKU20WMXVtIIDV0QUzNt5sL/uGSCuRSjz+XfKMwWrmYDSPMCPKwzhQJWZUAzkq
 5ZiKCStAZ3mi7aNle7UBR6BcdetgqEEMQOrrF2viYG9DfzS202kGxeEcyR/ihrfTlBTM=;
Date: Sat, 25 Jan 2020 16:20:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200125152023.GA18311@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-4-horatiu.vultur@microchip.com>
 <20200124174315.GC13647@lunn.ch>
 <20200125113726.ousbmm4n3ab4xnqt@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125113726.ousbmm4n3ab4xnqt@soft-dev3.microsemi.net>
Subject: Re: [Bridge] [RFC net-next v3 03/10] net: bridge: mrp: Add MRP
 interface used by netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

On Sat, Jan 25, 2020 at 12:37:26PM +0100, Horatiu Vultur wrote:
> The 01/24/2020 18:43, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > br_mrp_flush - will flush the FDB.
> > 
> > How does this differ from a normal bridge flush? I assume there is a
> > way for user space to flush the bridge FDB.
> 
> Hi,
> 
> If I seen corectly the normal bridge flush will clear the entire FDB for
> all the ports of the bridge. In this case it is require to clear FDB
> entries only for the ring ports.

Maybe it would be better to extend the current bridge netlink call to
be able to pass an optional interface to be flushed?  I'm not sure it
is a good idea to have two APIs doing very similar things.

   Andrew
