Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=s1JubaSys0W2CY3hegeWddwh82zIcRKHXJ9DnV/hFbU=;
	b=CAJmS0L9As6i5s+sHfRSSnaqpUrVu84MOj1IvnRU+Obqu52CSj/jIXCNwBwucp3Uzn
	DKgJYRsYyWDncPA+kNwUWXxbRJRLuSBiduXr1h1rdv2H7oZ0mf2kG4BnhWEOb4WBFbS/
	TBslvK3PmYxB5f44voTgwKD30ERifdR2DK/1McUxWwz2FvbMdy7A+0NM9hvjStWW/gtH
	L4Qysqeb8h1zqV02Dl1hGlSakgkOQpGRlLWAcWifXc5LuYKRijRAfpLtjz4oLC2F+huu
	hEHDpWBaxYIATOQNzfMKlB2ngJvthNek6Y76jG9wUwTM5h++84WWsxvN9qg7Lao38Ga/
	0+zg==
Date: Mon, 15 May 2017 08:57:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170515085734.3f8036f1@xeon-e3>
In-Reply-To: <87pofci3bt.fsf@coreos.com>
References: <87pofci3bt.fsf@coreos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] libbridge: Include the configured CFLAGS when
 compiling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Michael <david.michael@coreos.com>
Cc: bridge@lists.linux-foundation.org

On Sat, 13 May 2017 19:23:34 -0700
David Michael <david.michael@coreos.com> wrote:

> When compiling bridge-utils, the CFLAGS set during "configure" are only
> used in the brctl directory.

Sure make sense. I applied it (with some reordering).
