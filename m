Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Wed, 23 Nov 2011 20:52:18 +0200
References: <4EB8F874.8090408@cipi.unige.it>
	<201111081232.01748.vitas@nppfactor.kiev.ua>
	<4ECCD181.1010704@cipi.unige.it>
In-Reply-To: <4ECCD181.1010704@cipi.unige.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201111232052.18734.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] RSTP implementation status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Martino Fornasa <m.fornasa@cipi.unige.it>
Cc: bridge@lists.linux-foundation.org

On Wednesday 23 November 2011 12:57:05 Martino Fornasa wrote:
> I'm taking a look of the pointer you provided me.
>
> If I understand correctly, it should be possible to implement RSTP in
> user space, by using the actual kernel interface to the bridging
> subsystem. However, implementing MSTP should be a different issue, due
> to the interconnection with VLAN issues...

Yes, you are correct.
But you still can use mstpd as 802.1Q-compatible RSTP implementation and it 
works with current kernel bridging code.

-- 
Vitalii Demianets
