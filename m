DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=M2BhxTyXWOjrfC6+bsMU4wiILT59nrISlodpEMHmaFw=;
	b=rz3PXUJ+m7S5ojpvNrUHgCVyg35Pe3HvrM2sOzSnyWZ0DnK+o6hk/Bc0QrioO+rfRk23zisU/KDKEHW1yhj3sEDk2R32cJonIWVEqJLyRLTro3Mzt84qv1tjW1amqBXjJ7ytchJNc3UdwdOTHfgnzw1bB2JwyDio2xDBgF/cBWs=
Message-ID: <2e59e6970712252314k7130da4cwc468f9dc3528cb76@mail.gmail.com>
Date: Wed, 26 Dec 2007 07:14:38 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Subject: Re: [Bridge] bypass bridge for backup
In-Reply-To: <4734DDF4.9010102@gurutech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4734DDF4.9010102@gurutech.it>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: gianluca <gianluca@gurutech.it>
Cc: bridge@lists.linux-foundation.org

On Nov 9, 2007 10:23 PM, gianluca <gianluca@gurutech.it> wrote:
> Hi everyone,
> I'm using linux bridging for a trasparent firewall.
> There is some kind of external hardware that I can use to bypass
> my firewall in case of failure?
> I mean: if I power off my firewall I want to join physically the
> two network segments without reconnecting any wire (and possibly without
> touching any button)

Any switch that supports spanning tree will do... make sure that the
firewall is preferred (by setting spanning tree cost and priority),
then the other switch will start bridging automatically within a few
seconds if the firewall ever stops forwarding the spanning tree pdus.

>
> Thank You
> Gianluca
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
