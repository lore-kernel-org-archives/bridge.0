Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cHre5OH097+HwLmWHZeQS1FNkHMKBZRwd5ya8hQetiA=;
	b=0HyL8/Y3pGsimUpucc8s9TCkGmx3JBXhi6YNKtCqauQP28d2hErEPANQEMW73w5LND
	nGQ4PI7PndgaCu9J20dhdpXuvJp/OsfTXXQJUxajhPLx/hlBZWD01TF7rqz48iN2U5Ig
	bvnNiqBCu3e9I3weCXj2Lh5Y2gx6JpeMCN7nnI8hlrpMc/t40d4ezhG27/PBjfdNCIcE
	DFE9hMz5T9XiyBHPjFnHUWD10+buof+T8ZRXN5VfPFllJK6RDFWmIgcVwSk2MKFx65FN
	/9IIQ3u7+Az5ilXwyE/LddrgukWSut2NQXVQ094mA8U4syGtQqBOEv1fwWQas4wczwR/
	1L9w==
Date: Mon, 23 May 2016 10:23:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160523102306.15e7a5a8@xeon-e3>
In-Reply-To: <CAAoNYVNFqmandFB5MY5L2+zw=sAv47=0OBRrgU0whkJy_f6rZw@mail.gmail.com>
References: <CAAoNYVNFqmandFB5MY5L2+zw=sAv47=0OBRrgU0whkJy_f6rZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RSTP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: aaron chen <chenchanglong2016@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 20 May 2016 13:56:13 +0800
aaron chen <chenchanglong2016@gmail.com> wrote:

> Great bridge friends:
> 
> I port  linux-4.1.14 to my arm board, and the STP works fine in the loops
> of the boards. But I want a faster performance, so I need to use RSTP. I
> visit the www.linuxfoundation.org and it said "work is being done to
> integrate RSTP support in a future 2.6 release".
> 
> so, I want to know if the linux-4.1.14 supports RSTP ? How can I  use it ?
>  if not, could you give me some advices to port the RSTP to my board?
> 
> Best Wishes
> 
> Aaron Chen
> from China
> 2016-05-20

I haven't had time or motivation to update the kernel STP to RSTP.
If you need it I recommend using the MSTP daemon that was done by Cumulus.
 https://sourceforge.net/p/mstpd/wiki/Home/
