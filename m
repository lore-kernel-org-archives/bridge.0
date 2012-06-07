Return-Path: <knura9@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=sD1kn4Po8ZjgplMCRBurQwRaIoD07sSW1oaCDHhoZkU=;
	b=yp63CP4RTNheK4uHGh7u+363vpEu+4yWdbqNF53OTFQ9Effedw65Nc+E1nddsMIQs7
	3OehUrNA9UhN7Hc+QdDygqPjPr12fLfga+wCpY+Ebisph+hCdJLsXpiRDi1mu7aLtNS9
	jAIEnOy1SpE/xJdAZjudK1XVP8VjxmqVw578yRqizvkn8raCEXINcL6W6CK3SfbKqBuC
	BCBFkKnT/DAMEbcYNHiVyXz8AyMUvS68lMhKVKUrBgZA8ZPgVo7rt1MGycwKJtY4rV7Z
	GEFH/obSenaPs/Gj//jDkqHdJs85FkJ74jRUvzP26LIO/+SXtbt3YvtJT0hgS2Gt7t+T
	lNbw==
MIME-Version: 1.0
In-Reply-To: <4F95550B.6010409@gmx.de>
References: <4F95550B.6010409@gmx.de>
Date: Thu, 7 Jun 2012 22:10:31 +0530
Message-ID: <CAHhM8gDYt858nP9Z4V0zT6s=o80G+2TE5nWeOeejH6tXwaZ+rw@mail.gmail.com>
From: Arun Khan <knura9@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] wlan0 will not be automatically added to br0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linux Bridge <bridge@lists.linux-foundation.org>

On Mon, Apr 23, 2012 at 6:41 PM, Markus Feldmann <feldmann_markus@gmx.de> wrote:
> Hi All,
>
> i want my wlan0 added automatically to br0 on my Debian Squeeze Server. At
> the moment the ports eth[1-3] are running over br0. I am using kernel 3.2.9.
> The port eth0 is only for internet. eth[1-3] are for my local network at
> home. When i manually add wlan0 to br0 i can built up a communication
> between my laptop and my server. Therfore i execute the command <brctl addif
> br0 wlan0> on my server.
>

.... snip ...

For an ALIX box, I was looking at this link
<http://wiki.debian.org/BridgeNetworkConnections>  under "Bridging
with a wireless NIC"  and this
<http://www.linuxquestions.org/questions/linux-networking-3/wireless-wired-bridge-on-debian-squeeze-883201/>.

However, I switched to openWRT so I have no personal experience with
the implementation on Debian.  I would suggest that you try Voyage
Linux (Debian based).   It comes with a quite a few sample
configurations to setup an AP and you may be able to extend the
scripts to meet your requirements.

HTH
-- 
Arun Khan
