Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=XPpYtJgHXSQwbz+WHen0CqKIs5Q0YuIxYrIfRoFSBCA=;
	b=wCHiv/RClUDDN4oNm5RNz+SvY1loFX6IVul0ucFnke/hBZ8Ew0MtC8kstILy3DvV7X
	oUai/lYQ3yb2nqW5fs7t3mKjWf61fIP/mpwdFa4zL+bmzwUi5Ef/PQ6jW4wt+O6kyRXP
	7jbJYi3XVyaojPlSUGU5pnyZ4fiYXG4QNcMSoQaJ7OVsADh2AFBK4Z5kXE1bpjpzEFP9
	EH37gtTqTkaj8JoThRlvY6unglTIBVmYbfINEOhSy+/fXNj+45ZioT5/3z0eEr41WHdK
	65o8TBSV+3Kn/vhwuKtUQdIwiRdVhKHdw8uhXVt0CsyHPK6WxuSpLH73ozIDDLFZZJTP
	v1cQ==
Date: Thu, 9 May 2019 20:35:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190509203501.310a477c@hermes.lan>
In-Reply-To: <20190510025702.GA10709@eros.localdomain>
References: <20190510025212.10109-1-tobin@kernel.org>
	<20190510025702.GA10709@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2] bridge: Fix error path for
	kobject_init_and_add()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Tobin C. Harding" <tobin@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Tyler Hicks <tyhicks@canonical.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Fri, 10 May 2019 12:57:02 +1000
"Tobin C. Harding" <tobin@kernel.org> wrote:

> On Fri, May 10, 2019 at 12:52:12PM +1000, Tobin C. Harding wrote:
> 
> Please ignore - I forgot about netdev procedure and the merge window.
> My bad.
> 
> Will re-send when you are open.
> 
> thanks,
> Tobin.

That only applies to new features,  bug fixes are allowed all the time.
Also please dont send networking stuff to the greater linux-kernel mailing list.
