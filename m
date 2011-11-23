Return-Path: <m.fornasa.dei@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=rdo9rtrfO6v0unjLWyAS0/YJyQSiZm8/o1neiNqpchk=;
	b=Lfqmtr0qMC0vzPJ6wvBigOe/gsF2lOLQoNoITTSbHmPKyfmdLrOB7Osp/6KOzOEApX
	/43QJqrTx4oDZk4A1zYPILbnDLfsmpftj/VIprqQBBakCwvVij3qIzfxI0QQ1mqDlxOk
	mpP6+dUKZmvX5nQgB0YWhID0qg996dtSaJRhw=
Sender: Martino Fornasa <m.fornasa.dei@gmail.com>
Message-ID: <4ECCD181.1010704@cipi.unige.it>
Date: Wed, 23 Nov 2011 11:57:05 +0100
From: Martino Fornasa <m.fornasa@cipi.unige.it>
MIME-Version: 1.0
References: <4EB8F874.8090408@cipi.unige.it>
	<201111081232.01748.vitas@nppfactor.kiev.ua>
In-Reply-To: <201111081232.01748.vitas@nppfactor.kiev.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RSTP implementation status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Cc: bridge@lists.linux-foundation.org

I'm taking a look of the pointer you provided me.

If I understand correctly, it should be possible to implement RSTP in 
user space, by using the actual kernel interface to the bridging 
subsystem. However, implementing MSTP should be a different issue, due 
to the interconnection with VLAN issues...
