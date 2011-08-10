From: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
Date: Wed, 10 Aug 2011 09:54:58 +0200
Message-ID: <6680AE1BD102B9419251E785D19F5D039FA037F0@ExchN1.riedel.net>
Content-Language: de-AT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] possible bridge regression in "bridge: implement
 [add/del]_slave ops"?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Hello,

I had trouble with the new detection code for interface ports.=20
In turned out that the carrier was down, but IFF_RUNNING was set.=20
I changed the code to check for IFF_UP & IFF_LOWER_UP for interface ports a=
nd now it works the way it should.
Would it be better to check IFF_LOWER_UP or is my interface device driver i=
ncorrect?

Best regards,
Bernhard


----------------------------------------------------------------------

From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] possible bridge regression in "bridge: implement
        [add/del]_slave ops"?
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,  "David
        S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Message-ID: <20110705142858.3b7e5941@nehalam.ftrdhcpuser.net>
Content-Type: text/plain; charset=3DUS-ASCII

I just put a fix for the detection of bridge pseudo-device being up
into the current rstp code available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git


------------------------------

_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge

End of Bridge Digest, Vol 95, Issue 3
*************************************
