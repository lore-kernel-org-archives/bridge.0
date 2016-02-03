Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding;
	bh=XFhyGBrWgg7+9IMffxPPGA3LGaogpcOsrq4jRUbP2yU=;
	b=Zdv1Q1llVw6yy6Ox1wFfEVCxl4e8ie3ItP3l89cf69D3+fzZ41C4w8D8RqKy9tlyaz
	+TR70celbeg4KMHwbKNqCCo6/gD/jvbz7khblOWsPD8xgo5/jAyAdJoBwmGlMvP++OAn
	MQlgXS51kQ6LMQB5QTRuYRpJLtPWvZiVFF2NGZYmb/4WCLjqm32x8bzyRC3/MH6+lwrm
	NcLTYFc9jL4zipw5bkSb6iH82WMeikgQQEVytpwMfwdg4GJKDMBCsZaxizRiJafanrJn
	JEyG+D66dOyEKOHVpYqquQ7x/OaSRKZ6oUu/47kf5ktNrxgcKhxCwzkirnBEWdHlgmam
	ulfA==
Date: Wed, 3 Feb 2016 11:51:35 +1100
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160203115135.5654c1f5@samsung9>
In-Reply-To: <CAP9G-NKzk7QwFtD=YjqyFpt7sS+J=JYzCTPLjNAGoCTv_cxEMQ@mail.gmail.com>
References: <CAP9G-NKzk7QwFtD=YjqyFpt7sS+J=JYzCTPLjNAGoCTv_cxEMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Help with Ubuntu + bridge + tap + qemu + Windows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: gilberto dos santos alves <gsavix@gmail.com>
Cc: bridge@lists.linux-foundation.org

Read Wikipedia on Spanning Tree to see how it detects bridging loops.
Look at dmesg to see when bridge STP disables a port when it detects loop
