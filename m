Message-ID: <461B5615.3010304@cambridgebroadband.com>
Date: Tue, 10 Apr 2007 10:17:09 +0100
From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <AFB2687AB4F98E419EDFA205E376D41330618C@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
In-Reply-To: <AFB2687AB4F98E419EDFA205E376D41330618C@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
Content-Class: urn:content-classes:message
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Static filtering entries in bridging --
	linux	2.4.20kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Majjari Vikram(TLS-ESG), Bangalore" <Majjari.Vikram@hcl.in>, bridge@lists.linux-foundation.org

Majjari Vikram(TLS-ESG), Bangalore wrote:
> 
> Hi all
> 
> I think Static filtering entries are needed in bridging for security
> purposes. I read that we can add static filtering entries in to the
> bridge filtering database. The entry information includes the
> destination MAC address and the port number(other fields as required)so
> that when a packet/frame arrives with the destination mac address that
> was specified in static filtering entry the frame gets bridged/forwarded
> to the interface/port that we have specified in the table(as a static
> filtering entry).
> 
> 

Perhaps what you are looking for is MAC address based vlans.  Consult the
linux-vlan project - the latest code is able to do this.

Use the vlan module to create multiple interfaces layered over eth0 that
filter for the static MAC addresses you're interested in.  Then choose
which bridge to add each interface to, based on the services you wish that
MAC to access.

(BTW, I haven't actually used this code myself.  I submitted the original
patch, but I handed it over to the vlan maintainers and they've added
a lot of functionality and changed the usage.  In short, I can't help with
the details - you'll have to look it up in the linux-vlan documentation.)

Alex

------------------------------------------------------------------------------

Cambridge Broadband appoints telecoms industry veteran John Cronin as chairman <<http://www.cambridgebroadband.com/mi20feb07.htm>

Maxis to upgrade its backhaul network using Cambridge Broadband; Alcatel-Lucent selected to manage entire upgrade project <http://www.cambridgebroadband.com/mi12feb07.htm>


------------------------------------------------------------------------------
Cambridge Broadband Networks Limited
Registered in England and Wales under company number: 03879840
Registered office: Selwyn House, Cambridge Business Park, Cowley Road, Cambridge CB4 0WZ, UK
 
This email and any attachments are private and confidential. If you believe you have received this email in error please inform the sender and delete it from your mailbox or any other storage mechanism. Cambridge Broadband Networks Limited cannot accept liability for any statements made which are clearly the individual sender's own and not expressly made on behalf of Cambridge Broadband Networks Limited.



