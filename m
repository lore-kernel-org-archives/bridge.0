Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 24 Mar 2020 22:01:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
 t=1585083710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=01kEU6273rx0YUr5+eRtgMVfKmZgR9efexTE9Ovwaqg=;
 b=jnGfBC9PgsmcyW7R2ds7Indltism9qd5iYbztJKbdaRVg2nSijM6ns33oTKwRiXivzId17
 wGiHHOSebBPsgQcn9LwE+dU0LGdfUFp4gb5xWbPT5i1w2v32ISJQbKGu1CickyN2HzAPbi
 Pze0V4isdguXab9/c2QK6HJR/06APK+qhF4E0aA2v0ruZL/WadZ9RvYEVrN5wffKpSG7hS
 7t+y2sY3sv/EfL90m49HyOc0CBDZ66ygN7BUohJ7Twz1ObEzU3iZNxAD3xzk5NXUu6oGBb
 3KXRozuXVOcEaUbqLdy90xs/EcrQu01ZrtJM56Gz+AE/s3QsgWK4X5NY9a77Yg==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20200324210149.GE2357@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Fwd: [Mcast-wifi] Issues with MLD and Android powersaving
 / sleep mode...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

And speaking of adoption and experiences, an annoying issue with
MLD+Android we came across lately.

In case someone would like to participate and help on this, too.
Implementing some workaround in the Linux bridge might be
something worth to consider, too.


----- Forwarded message from Linus Lüssing <linus.luessing@c0d3.blue> -----

Date: Tue, 24 Mar 2020 21:54:02 +0100
From: Linus Lüssing <linus.luessing@c0d3.blue>
To: mcast-wifi@ietf.org, pim@ietf.org
Subject: [Mcast-wifi] Issues with MLD and Android powersaving / sleep mode...

Hi,

With Freifunk [0] we lately came across an annoying issue with Android
devices... which I'm not really sure how to solve yet...

It seems that (some?) Android devices do not respond to MLD
queries when in sleep mode:

https://github.com/freifunk-gluon/gluon/issues/1832
https://issuetracker.google.com/issues/149630944

Which causes severe IPv6 connectivity/usability issues
when trying to use MLD snooping capabilities.


As soon as you turn on the screen of the Android device or
connect a charger MLD Reports arrive just fine. My test results
were, as noted in the Android ticket:

Results with phone on battery:
* 0/8 MLD Reports received
* 3/8 Neighbor Advertisements received
* 8/8 Echo Replies received

Results with phone on charger:
* 8/8 MLD Reports received
* 8/8 Neighbor Advertisements received
* 8/8 Echo Replies received


Fixing this on the Android devices would need several years to
propagate, as noted by an Android dev.


Has anyone on this list experienced similar issues, too? And is
there maybe even someone who came up with a workaround that they
implemented on the router/switch side?

If not and if we can't come up with a solution it looks pretty
gloomy for (non-flooding) multicast in wifi networks to me for
the next years...

Regards, Linus


[0]: https://freifunk.net/en/

_______________________________________________
Mcast-wifi mailing list
Mcast-wifi@ietf.org
https://www.ietf.org/mailman/listinfo/mcast-wifi

----- End forwarded message -----
