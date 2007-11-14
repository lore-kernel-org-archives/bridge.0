DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
	bh=HztxT6wScaxGm/tdF2TQCOGBGsyYVV9YNmDaYTrtIhI=;
	b=KysAI9NUMiQSBLcru9nfEv21xt/VLFPvSZOhwzHeJlYPjGRviz5Tj02lAWaO2syiu6Qj5LE4I757pc0b9I2ErWFFT48dgX6+++Bzj53YSBibBboJnt2/QjL24cGj4Lo7vQckYfDCi3fObKZJIyRMRJaADHsROJQ0OXq4weFvtXc=
Message-ID: <bdfc5d6e0711140809oa82deefg2aa72722dc91d5ba@mail.gmail.com>
Date: Wed, 14 Nov 2007 11:09:46 -0500
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
Subject: Re: [Bridge] Rx Buffer sizes on e1000
In-Reply-To: <96CF49BD8B56384395D698BA99007FA32D53@exchange.pacwire.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <96CF49BD8B56384395D698BA99007FA32D53@exchange.pacwire.local>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Nov 14, 2007 12:26 AM, Leigh Sharpe <lsharpe@pacificwireless.com.au> wrote:
>
> Looking at this a little further, the stats on the ethernet card (from
> ifconfig) tell me that it has transmitted as many bytes as it has
> received, which indicates that the bridge itself is not dropping the
> packets. I'm back to the idea that the card sn't delivering them to the
> bridge somehow. Hence my first guess about buffer sizes.

The e1000 module does have options for Tx/RxDescriptors (buffers), but
I'm not sure that's going to help you too much.

> As far as MSI goes, I have it enabled in the kernel (looks like it's
> default for 2.6.18?), but I see nothing in the logs referring to MSI. Is
> there any way of checking whether it's enabled and working? Or is it
> only a PCI-X thing?
>


$ cat /proc/interrupts
