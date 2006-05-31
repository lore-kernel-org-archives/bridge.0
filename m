Message-ID: <447E0456.10609@arcoscom.com>
Date: Wed, 31 May 2006 23:02:14 +0200
From: =?UTF-8?B?U2FtdWVsIETDrWF6IEdhcmPDrWE=?= <samueldg@arcoscom.com>
MIME-Version: 1.0
References: <447CBD31.2090802@arcoscom.com>	<20060530162106.30702d1b@dxpl.pdx.osdl.net>	<447D77A4.5050205@arcoscom.com>
	<20060531091022.12361f66@localhost.localdomain>
In-Reply-To: <20060531091022.12361f66@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] setportprio problem with bridge-utils 1.0.6
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Thanks Stepen, again, and sorry for my english, perhaps is this the 
problem too: my english.

I want to set port prio, to values as 1, 2, 3, 4, etc.. (little values), 
my problem is that when I run:

brctl setportprio br0 eth1 3

That "3" goes to "port cost" no goes into "port priority", that is my 
problem.

Any help more?

Stephen Hemminger escribió:
> On Wed, 31 May 2006 13:01:56 +0200
> Samuel Díaz García <samueldg@arcoscom.com> wrote:
> 
>> Thanks Stephen.
>>
>> The problem is I want to set the port prio, not the cost. The cost is 
>> working (at least brctl showstp br0 shows fine, gg).
>>
>> Would work with ..../port_prio too?
> 
> You know that port_prio is limited to 6 bits now that bridge can have up
> to 1024 ports.
> 

-- 
    Samuel Díaz García
     Director Gerente
ArcosCom Wireless, S.L.L.

CIF: B11828068
c/ Romero Gago, 19
Arcos de la Frontera
11630 - Cadiz

http://www.arcoscom.com

mailto:samueldg@arcoscom.com
msn: samueldg@arcoscom.com

Móvil: 651 93 72 48
Tlfn.: 956 70 13 15
Fax:   956 70 34 83
