Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding;
	bh=r2vO8I5rZC1YfcA0/M8BU9rBIZ5bUsZuQwY7OK4eeFk=;
	b=PaYu+RwV6zzlxNfAqkApa2MyTu9qR7YP6bjjxgJnsflwpP3t0hfOrj21txPR9lCWwN
	xgzESW67Yf/V8HnIKrDit4AJiEkxksWSkb1NC3Of54dV+wYIfvW1ENudkIzyB3i/4fLU
	hEzl99tAIviQl2vmexgQGzYEHPPwKcwt3ryOF6saX5sSY0fc4NTXlpgmf3AaIJbgUhj5
	aHdgkUPnzxt+sUNv68w4yYZeoOJo07IQrRIxaMZDv6l9uPlPSG8zl05+dcrfAT2JMscD
	33+ldmYLeoaIPkk0a8lHtoVxjPCGi4Xhcb1ayhXw1CeflTSaSyXxB2F1Fa4wlEDVYOaF
	eGAQ==
Date: Tue, 2 Feb 2016 14:27:08 +1100
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160202142708.512d1cc8@samsung9>
In-Reply-To: <6B2C2A75-2FC1-4938-B8FD-19D9325583A4@gmail.com>
References: <5FA3B72D-03E5-43BD-B635-6A46070C6898@gmail.com>
	<6B2C2A75-2FC1-4938-B8FD-19D9325583A4@gmail.com>
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
To: David Logan <djlogan2.dl@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 1 Feb 2016 13:04:48 -0700
David Logan <djlogan2.dl@gmail.com> wrote:

> oops. Wrong machine. The uname -a really is
> 
> Linux server2 3.16.0-59-generic #79~14.04.1-Ubuntu SMP Mon Jan 18 15:41:27 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
> 
> David Logan
> 
> 

I suspect you have a loop and STP is detecting that the STP packets being sent
out one of the ports on the bridge are showing back up on another port on the bridge.

The way bridging works you need to make each port on the bridge is a separate L2 domain;
otherwise you create a loop.
