Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pdbViBEd36I19JNUQskQaHx0WbnqXEeOOznNCZBvO5o=;
	b=nQ6GvE9iMHAPndtemfXq+PsN0TPSBIk/XEX3yhvlMNezuFqf7sDkahRosGU1k14VKd
	d7I9shbnkPYjR2GP2vGLOVUX/mFTIORnMALJ0Fr++1wW/GAKLsP1iwQzP2qf5z1tJkzM
	N82nmuz4UDvVENO7qFXwVZSGKtA2UnfC6UOtoS0lMII+OHrpWHMsWObPYK5FiMBTh8+I
	3QPoiH7s1ie9CHvdQuZNuFRPbxhxp6lnAmN1oaiO3rY8xQ2tUdAzDG+Mrvb2qN2iPaeT
	w0nYqdG7nrlo8+D13/4EdnUJFaI4QFrX69hCi5D8XAGwyQIC9K/khPL3X2ARqXYrL84u
	h+OQ==
Date: Tue, 19 Dec 2017 10:32:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171219103256.07405db1@xeon-e3>
In-Reply-To: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
References: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v1] bridge: Use helpers to handle MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Tue, 19 Dec 2017 20:10:53 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use
> 	%pM to print MAC
> 	mac_pton() to convert it from ASCII to binary format, and
> 	ether_addr_copy() to copy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
