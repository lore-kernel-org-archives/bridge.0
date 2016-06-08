Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cccKBM/OCvac+wDnQpngNkDftE7Rq1SFqfCeYXA+Okw=;
	b=s3FfRt/4h4a7qSULnN4gI+LpSm9/E6x3YZx0Htsge4uGi6Bs7jgBS2stV+oTJhtucW
	TYfuTdI9El4dHGYAGfEyGsLoi9fmcOQ4p5C9ugdbPg0AyJD8k+6gPWkWk1AJvqfp1yAT
	QKoFEytPz11PzdbyCNIt96PzbMBM/8wVlfWKV0VMmbHjC5wwk1p31eIJbJgSrNc7rZ7/
	Qdu7eHzJ5+/TF+F3ZLkwIJOQ15GQgryXyJNPUhvTIefnnRy9+xbp/frKUsHZFOFqDIt5
	/kLEG9hSJs6j4DxuvFFXGZ4BnmtR95onbpPAS7xNL4jdZUD2/zWGcpLsgmkgUvsC42TC
	F6oA==
Date: Tue, 7 Jun 2016 18:50:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160607185023.03519b4b@xeon-e3>
In-Reply-To: <CAKWq4gNPD5m_=-WPDZWzS0GOgkyHYtY3yh0wsJJy9+gohiwhtg@mail.gmail.com>
References: <CAKWq4gNPD5m_=-WPDZWzS0GOgkyHYtY3yh0wsJJy9+gohiwhtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] NFS connection drops as interface added to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Udaya Puvvadi <upuvvad1@binghamton.edu>
Cc: bridge@lists.linux-foundation.org

On Tue, 7 Jun 2016 12:20:42 -0400
Udaya Puvvadi <upuvvad1@binghamton.edu> wrote:

> Hi,
> 
> I am running PXE boot with Debian Stretch image, with eth2 interface
> bound to kernel for doing NFS mounts.
> 
> I am trying to add this interface to the bridge, for network
> communication across virtual interfaces, however the NFS drops
> connections as soon as I add the interface.
> 
> Can you please help me on how to do the NFS mount's over a bridge connection ?
> 

There are two possible issues:
1. When an interface is part of the bridge, you must not try and use the interface
   directly.  I.e once eth2 is part of br0, don't use eth2 again. Most importantly
   never assign an IP address to the interface. Many people doing this kind of thing
   end up reading the IP address of the interface (eth2), then removing all addresses
   from the interface (eth2) before assigning it to the bridge, then apply the IP address
   back to the bridge device.

2. The bridge device itself has a MAC address for local packets. This MAC address is
   based on all the devices in the bridge (by default). Therefore when eth2 is added
   to a bridge with other devices present, the MAC address for locally sent packets
   will change.

