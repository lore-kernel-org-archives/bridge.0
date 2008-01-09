DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=qhS+WFsfotTQhM6S2VRz8+4ZyOz3iZDf3lzxEcbeIKI=;
	b=tEyGVoct5F4KWzV51XXy29mSltmMxRK5ifhSqfUQzfLgfC7+HRkxxdVnCIhfagYeHN9i3ZGiyKWe+5TMKwCngMJDTnXjRiDyozQkO1MQFwiXDLlGpJnim7i5p0388l+fxNmouIj7RfSoE7vqZCjUfYVvI+UUdiqVs/cvJmTDKRk=
Message-ID: <9e0cf0bf0801091016n50f1f3f7kfb0326ca3014dbfd@mail.gmail.com>
Date: Wed, 9 Jan 2008 20:16:48 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [Bridge] Re: [ANNOUNCE] bridge-utils 1.4
In-Reply-To: <20080109063654.M87339@visp.net.lb>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080108085607.37ab168f@deepthought>
	<20080109063654.M87339@visp.net.lb>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Denys Fedoryshchenko <denys@visp.net.lb>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

On 1/9/08, Denys Fedoryshchenko <denys@visp.net.lb> wrote:
>
> As mentioned in
> http://marc.info/?l=linux-bridge&m=113105949718826&w=2
>
> Released package doesn't contain ./configure script
>
> For people who know what is make on, it is easy to run autoconf , but some
> know only how to use ./configure :-)

Also use of automake will be great!
If you like, I can provide new autoconf/automake build for this package.

Alon.
