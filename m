Return-Path: <gy2kre@centrum.cz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=centrum.cz; s=mail;
	t=1401222744; bh=dXj9TQkQU+zIKIJr0esrd8xdV5MQ9vWY4luuae2Hb7Q=;
	h=To:Subject:Date:From:From;
	b=gcjUN9u3n9DKlZp4wFBVxjnBe5WjmFTZKoeUp8AjQS+YJLZ0iM+04L5tf1zqNArMG
	5RVSqHpYzsyfnfYMXZPwLh2HSW5+2Ftb2XzvSorWnWFXj/NC2C8+APJ6KRp8zbtiwA
	dix2ISn/QP8ZKUfVSt6pcCQ8JGFnrzKJYibDhB28=
Date: Tue, 27 May 2014 22:32:23 +0200
From: =?utf-8?q?Milos_Gajdos?= <gy2kre@centrum.cz>
MIME-Version: 1.0
Message-Id: <20140527223223.EB230DF3@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] =?utf-8?q?Create_bridge_using_rtnetlink?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Guys,
I've been thinking about this past few days and thought I'd ask here.
Is it possible to create bridge device using rtnetlink interface ?
I've tried to go through iproute package source but got a bit overwhelmed and confused.
Could someone give me a hint how to go about it ?
I had a look at bridge utils source but that one literally uses direct syscalls.
What I'm after is rtnetlink thingy which would correspond to:

ip link add name mybridge type bridge

Any advice/hints would be very appreciated!
thanks
