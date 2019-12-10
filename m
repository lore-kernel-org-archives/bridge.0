Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=tPg6HNf3WY8ezIcG4ChbTF8Z6mYyQlYkzlIgv8Ay1G4=;
 b=nE8UgUJtn+wZBfPfQc9Kq8XZE/NBo5vuY5hCaYf6g6ft38NS2ub1gyF+Z7ue6zCAaY
 fg82czGJCLVajza/WZTB7T8FUAUJM81ERVaH7iG7J4gyCtRX1eVi/zZR7E/fLGGSmN3u
 E9vgL/GwbtMd3J9NNG1XS4soWjFM3rE0QQr1Xn1nek4OoaAfxXZKbTBiu53kROlK6bQm
 BUOEIihJeok88kcFgYkJYReIuBjuhl1hMc8zuF07xbTL6mHXHrmMGRYYXloD4A7aqQrR
 43y+oIVzY5WfrL04wULu9vw+KrIP5yZT2bWPHZXfgxYnYHkwjA21mb+pTBp2IFXqmShy
 etdA==
Date: Tue, 10 Dec 2019 15:10:47 -0500
Message-ID: <20191210151047.GB1423505@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <2f4e351c-158a-4f00-629f-237a63742f66@cumulusnetworks.com>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
 <20191210143931.GF1344570@t480s.localdomain>
 <2f4e351c-158a-4f00-629f-237a63742f66@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

Hi Nikolay,

On Tue, 10 Dec 2019 21:50:10 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> >> Why do you need percpu ? All of these seem to be incremented with the
> >> bridge lock held. A few more comments below.
> > 
> > All other xstats are incremented percpu, I simply followed the pattern.
> > 
> 
> We have already a lock, we can use it and avoid the whole per-cpu memory handling.
> It seems to be acquired in all cases where these counters need to be changed.

Since the other xstats counters are currently implemented this way, I prefer
to keep the code as is, until we eventually change them all if percpu is in
fact not needed anymore.

The new series is ready and I can submit it now if there's no objection.


Thanks,

	Vivien
