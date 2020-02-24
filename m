Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=date:in-reply-to:references:mime-version:content-transfer-encoding
 :subject:to:cc:from:message-id;
 bh=qPiprPPWOXKnPPDBG4O0xCF4AFbKQDRfeTyRm4fHf48=;
 b=T6711nbGJFtACfO8Li5uHflBgNtZ9UemEEG66EgJSxj7oeeXGJKDF14QhR3U/bVPGK
 CcDbQJcXp3wgFeKxl79HhwVvEuWAH3bkMNzuAeNm3pIZGPugPDkJxXNHuO+hFIPqO+V4
 nPzzkesTKw9jiIOQwznxCTCIKeo+0vy89ubD4=
Date: Mon, 24 Feb 2020 19:06:39 +0200
In-Reply-To: <20200224085427.0358ed8c@hermes.lan>
References: <83cadec7-d659-cf2a-c0c0-a85d2f6503bc@cumulusnetworks.com>
 <20200224164622.1472051-1-nikolay@cumulusnetworks.com>
 <20200224085427.0358ed8c@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <D49B5587-5365-4B09-9728-0BE23056A974@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix stale eth hdr pointer
	in br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 24 February 2020 18:54:27 EET, Stephen Hemminger <stephen@networkplumber=
=2Eorg> wrote:
>On Mon, 24 Feb 2020 18:46:22 +0200
>Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom> wrote:
>
>> -	eth =3D eth_hdr(skb);
>>  	skb_pull(skb, ETH_HLEN)
>
>you could just swap these two lines=2E

Can't, still caching the wrong mac_header offset=2E br_allowed_ingress() c=
an change the head pointer and also the offsets inside=2E=20


