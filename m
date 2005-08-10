Message-ID: <42F9948D.7040006@netd.com>
Date: Wed, 10 Aug 2005 11:15:49 +0530
From: Prasenjit Manna <pmanna@netd.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Designated port Selection
References: <EDF30175FE4D804B83444FB153172A506D73FB@louexch.KiZAN.net>
	<42F6FDCA.7090809@netd.com>
In-Reply-To: <42F6FDCA.7090809@netd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am sending this mail once again.
Please have a look and give me some suggestions.

Prasenjit Manna wrote:
> Hi,
> 
> I have two questions:
> 
> 1. br_designated_port_selection() in br_stp.c:
>    In this function, the port, which is not DISABLED and
>    br_should_become_designated_port, then the port is becoming
>    designated port.
> 
>    Question: Why the port state(DISABLED) is checking here? According to
>              standard, there should not be any checking for disabled.
> 
> 2. br_stp_set_bridge_priority() in br_stp_if.c:
>    In this function also, the same DISABLED checking is done.
> 
>    Question: Why the port state(DISABLED) is checking here also for
>              updating the bridge priority?
> 
> 
> Thanks and Regards,
> Prasenjit
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 
