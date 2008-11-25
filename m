Message-ID: <20081125171134.11393if2ph1nt3gm@w0.mail.sapo.pt>
Date: Tue, 25 Nov 2008 17:11:34 +0000
From: Joao Pedro <countzero@sapo.pt>
References: <20081125153116.42936yyfpzcbl8p0@w0.mail.sapo.pt>
	<89ADFB63BC286B49BC71F1D34A7E38D612E30B@EXVS01.aenigmacorp.com>
In-Reply-To: <89ADFB63BC286B49BC71F1D34A7E38D612E30B@EXVS01.aenigmacorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; DelSp="Yes"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging VLANs and PVST+
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Geoff Wiener <gwiener@aenigmacorp.com>
Cc: bridge@lists.linux-foundation.org

(Sorry, forgot to CC the list).

Hi Geoff, thank you for your answer.

Geoff Wiener <gwiener@aenigmacorp.com> wrote:
I've had this very issue.  I know that 2.6.24-16 allows PVST BPDUs to  
cross the bridge.  Linux won't speak Cisco PVST+ but it will pass the  
BPDU's so that Cisco devices on both sides can communicate about the  
link state.
But isn't that part of the problem?
Imagine this situation, I have:
1 physical interface - eth0;
2 virtual lan interfaces - vlan15 and vlan16.
1 bridge - br0 - bridging vlan15 and vlan16.

The reason I have to filter the PVST+ BPDUs out (with ebtables) is  
that, when the Cisco switch sees a BDPU on VLAN 15 that belonged  
originally to VLAN 16, it will assume a loop was detected and shut  
down the switch port where eth0 is connected. If Linux could convert  
the VLAN 15 BDPU to a VLAN 16 BDPU, before sending it to VLAN 16, I  
believe the problem would be solved.

Regards,
JP
