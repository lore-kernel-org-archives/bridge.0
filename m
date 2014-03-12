Return-Path: <ajaykanala321@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=h04ZUfzImrQzCwZHy+WJJX3Lp4Ltq2FB0hx9ydfP4YI=;
	b=R6dUXo6jKyLqW8G7Xh9k9rLA2NsXnL+SowtaTWvUuTAevYXGalWVKCVz781/x14oTz
	EHXy4AFjLmJXGTLb5YXJR2JGvjD97qR1e/Yll0/C/ksiLzQCzPeDtGiNi84t1BY6L8PT
	2MDSf+xr8OGUgpsxiRqrCFnbRmqawWI1tMvxrHFf+M6AlG+lHBktebqD/r0zVtZNIVv0
	KZCi84ze1KpuWUl0HSk5uSX0PIVYx9XAjOa7FNyG9XDBh12+jftNCj44QUdHFMeLJg8u
	rAwjc3yXHm0OlB3cgmraUW2XD+JF7sC4UXqw8sy48uE1RMowgcag4XV2rPSN9TAHnZE6
	L9Ug==
MIME-Version: 1.0
Date: Wed, 12 Mar 2014 22:25:36 +0530
Message-ID: <CAFxy--YE-jVQ2CH9gUgUsyTpAvJHYfHEApAMUR0JNynMM2DLKw@mail.gmail.com>
From: ajay kanala <ajaykanala321@gmail.com>
Content-Type: multipart/alternative; boundary=f46d044630a8a9b6eb04f46bb406
Subject: [Bridge] linux 3.10.12 bridge gso with ethtool
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--f46d044630a8a9b6eb04f46bb406
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I am not sure if this is the right forum, please guide me to the right one
if not.

I am using a mips linux based router where i used linux kernel 2.6.32 for
some time. In such scenario, i could turn off gso of a linux bridge using
ethtool without any problems ( i had eth0 under br0 ).

Recently i switched to kernel 3.10.12 and setting on gso flag using ethtool
on the bridge interface br0 does not work and always throws up error "Could
not change any device features".

I am clueless what to do here as my device drivers are same across kernel
upgrades. I only changed ethtool version to 3.10. Any pointers would be
appreciated.

Thanks for your time ..

regards
ajay

--f46d044630a8a9b6eb04f46bb406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br>I am not sure if this is the ri=
ght forum, please guide me to the right one if not.<br><br></div>I am using=
 a mips linux based router where i used linux kernel 2.6.32 for some time. =
In such scenario, i could turn off gso of a linux bridge using ethtool with=
out any problems ( i had eth0 under br0 ).<br>
<br></div>Recently i switched to kernel 3.10.12 and setting on gso flag usi=
ng ethtool on the bridge interface br0 does not work and always throws up e=
rror &quot;Could not change any device features&quot;.<br><br></div><div>
I am clueless what to do here as my device drivers are same across kernel u=
pgrades. I only changed ethtool version to 3.10. Any pointers would be appr=
eciated.<br><br></div>Thanks for your time ..<br><br></div><div>regards<br>
</div><div>ajay<br></div><br></div>

--f46d044630a8a9b6eb04f46bb406--
