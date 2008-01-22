DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=a//zAdLgiKJgQKN5hwOJqgn2nS6qPfhxeooso47v4LY=;
	b=K6Pe+9N/L+S3tMxKADqX9hok4o12Vqy9iajPSaoPlNPmWODXHpcJyQyQ8t36VS6YPY6+yq0uFSP3eXojxxggihQw/u2mAr7wC2enrrXjYJ/W8quPxapR6hUsnXmcVbZ1jnXY4ys1h75fT2TtlRhQZ9E8bkT3C9NnMOFtDEq61Yg=
Message-ID: <2e59e6970801212158s42350483n75941bb4f58124a5@mail.gmail.com>
Date: Tue, 22 Jan 2008 05:58:11 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Subject: Re: [Bridge] MAC addresses on ports
In-Reply-To: <478E102C.8050006@satca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <478E102C.8050006@satca.net>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Marian Jancar <m.jancar@satca.net>
Cc: bridge@lists.linux-foundation.org

On Jan 16, 2008 2:09 PM, Marian Jancar <m.jancar@satca.net> wrote:
> Hi,
>
> I need some explanation/help with a probably bit uncommon bridge setup. I have
> devices that come with their manufacturer MAC addresses, and I need to create
> a bridge that uses my MAC address instead and has to look about like this:
>
> br0:    unique MAC address from my range
> wlan0:  same MAC as br0
>         (madwifi supports 4 MAC frames in STA mode so the actual bridging works,
>         just if you are curious :p)
> eth0:   any MAC address higher than the br0 MAC,
>         and as long as the assumptions below hold, unique in just this bridge,
> eth1:   ditto
> ...
> ethN:   ditto
>
>
> Now, the only reason I can think about from my naive point of view, why the bridge
> cares about port MAC address at all, is maintaining a reliable and persistent
> connection between the logical port and the actual physical device for STP
> purposes.
>
> So if I'm right, I can assign any MAC addresses to the ethernet ports, as long
> as they are higher than the wlan0 address, to ensure that the bridge selects
> the wlan0 MAC as its own, and as long as they are locally unique.
> The MAC addresses of the ethernet ports will not appear in any non-STP
> packets and don't have to be globally unique, because they identify ports in
> just this bridge and STP handles that, just a port has always to have the
> same address and not a random one.
>
> Is this correct? If not, is there any other way to create a bridge and
> not to have to allocate a unique MAC to each port?

I'm pretty sure you have it nailed except for one thing... what is all
this "higher than" another MAC address?  There's no ordering defined
for MAC addresses, and it wouldn't matter anyway, in my experience the
bridge takes the MAC address of the lowest-numbered port, that is the
first one added to the bridge, without regard for the addresses.

So you can just let ethX use the manufacturer assigned addresses, as
long as you add wlan0 to the bridge before ethX.

>
> Any comments and/or pointers to relevant documentation are highly appreciated.
>
>
> Best Regards
> Marian
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
