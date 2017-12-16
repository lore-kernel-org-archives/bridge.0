Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wDZD95ca6xp6Iu7trBOukzzoQL1MXCCY3WeuohOUw6Q=;
	b=njcoaJdA8eARkIZSpB7EECXW6drvRY5WI7qYhdrmuWZG/oLA1Zn6lcS0xBqZU3DUls
	C/YeaUrvy4UuNdQ+ReGqAIHPVgJ7+8GUzy+Npbq1KD65f8yKYWJYwRXYQceiFq+2H68q
	qevhqUFR9e3KhdPV0Ubz3Hth1ZVQ57CPuD1S5x2gzQQGfFnmKSd8Ljf41b/hvsECWcXl
	Itympl4XDqYVJ7W6AcWCPU1LatYcYlJk3LWFlGcJmNmrlYzj1lfP8C0IVTkdt61Gjwx2
	SRCrR7+dfE4tIEnR8tixu+CVFVUUQG7rYofonSdNbzATahZ8Vu/knEAFPly6t7idJEzs
	h2uQ==
Date: Sat, 16 Dec 2017 09:35:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171216093520.74b7fafd@xeon-e3>
In-Reply-To: <CA+k9h3PN8xmXe0kSWOYsP=Rj6vK00ExPYPnPRF6hiKvECLimAQ@mail.gmail.com>
References: <CA+k9h3PudMEAC7geZ7PPvR4m-6_9X4bFnWcvrBkb4sst0q3v8Q@mail.gmail.com>
	<20171215075512.6138a258@xeon-e3>
	<CA+k9h3OQen=ySLH_JyrqTNyHKOkgK+eFtB8JKKLpokiZN+OuPg@mail.gmail.com>
	<20171215174709.4cea5b98@xeon-e3>
	<CA+k9h3PrJK4u+wzQZWBxQxL-EN8gFx0wVCX6GZ_MkvU91VGieA@mail.gmail.com>
	<CA+k9h3PN8xmXe0kSWOYsP=Rj6vK00ExPYPnPRF6hiKvECLimAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux bridge does not forward arp reply back packets
 in a vmware vm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adrian P <adrian27oradea@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sat, 16 Dec 2017 16:19:03 +0200
Adrian P <adrian27oradea@gmail.com> wrote:

> Investigating this further, I have noticed that the mac address of the
> eth0 interface from the cirros VM instance does not appear in the
> bridge forwarding table, and this explains why everything starts
> working only when I set ageing time to 0, because in that case all
> packets are flooded on all ports and the bridge behaves like a hub.
> 
> So now the question is: why the bridge does not learn the mac address
> of the eth0 interface from the cirros VM instance? I am able to see
> the arp request (ARP, Request who-has 10.20.21.1 tell 10.20.21.233)
> going out from the cirros VM instance on tap interface, so the bridge
> should learn the mac address and add it to the forwarding table.
> 
> The reply back to the arp request (Reply 10.20.21.1 is-at
> 00:17:08:c4:52:80) does not reach the cirros VM instance anymore, and
> now I know why: there is no mac address in the forwarding table, so
> the bridge does not know on which port to send the arp reply back.
> 
> This happens with tap interfaces only. I can see many mac addresses
> associated with "physical" interface ens160 (that is interface number
> 1) in the forwarding table, but in case of the tap interfaces, there
> are only two entries, and both entries shows the mac address of the
> tap interfaces only:

VMWare does ARP spoofing maybe it consumes the ARP
