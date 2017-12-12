Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xgYzhRjXJW9puqpiDjeT26AcTUZTx4W/J3pG8OAtsaQ=;
	b=olm0eRCeRni+xu8l3bxEk/Sye8PBjn7Tv4c/iZRGa518eSP8Jo8nX8YE8GA/rJDBO0
	hEkuIRnuYbijTum7Ln11FeXcVxATkEX7KONWGesabpPHOX8uwvXIWkk+IhP1l4wKjYuP
	w9dihCiyI+Bg+qnseSli8/sdbi8uhJWAVyrghDH7QBJHVOSI0V+mQQbfDJ3cVTeRncC6
	49dKqy5jR66NFh67b5r3yjp5X384PYxjN7PoRdkEH9Z7Eifet8PdnChEtoVDolvWo3Yy
	yVdUPirG7ONYPXAj8+SVAykjEHzchsVyEo+0/jOyM5mTyF+ofN5JzGcFXkgf9fW4wdix
	p5TQ==
Date: Tue, 12 Dec 2017 10:02:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20171212100224.1aa33a96@xeon-e3>
In-Reply-To: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use rhashtable for fdbs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, srn@prgmr.com

On Tue, 12 Dec 2017 16:02:50 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> +		memcpy(__entry->addr, f->key.addr.addr, ETH_ALEN);

Maybe use ether_addr_copy() here?
