Date: Tue, 10 Feb 2004 16:29:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040210162906.5b2ef8e9.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Another bridge ioctl API alternative
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: bridge@osdl.org

The other alternative would be to copy the BSD ioctl interface.
Haven't looked at it in detail, but it seems reasonable.

================================================================================================
     A bridge interface responds to all of the ioctl(2) calls specific to oth-
     er interfaces listed in netintro(4). The following ioctl(2) calls are
     specific to bridge devices.  They are defined in <sys/sockio.h>.

     SIOCBRDGIFS      (struct ifbifconf) Retrieve member interface list from a
                      bridge.  This request takes an ifbifconf structure (see
                      below) as a value-result parameter.  The ifbic_len field
                      should be initially set to the size of the buffer point-
                      ed to by ifbic_buf. On return it will contain the
                      length, in bytes, of the configuration list.  Alterna-
                      tively, if the ifbic_len passed in is set to 0,
                      SIOCBRDGIFS will set ifbic_len to the size that
                      ifbic_buf needs to be to fit the entire configuration
                      list, and will not fill in the other parameters.  This
                      is useful for determining the exact size that ifbic_buf
                      needs to be in advance.

                      The argument structure is defined as follows:

                            struct ifbreq {
                                    char ifbr_name[IFNAMSIZ];    /* brdg nam */
                                    char ifbr_ifsname[IFNAMSIZ]; /* if name */
                                    u_int32_t ifbr_ifsflags;     /* if flags */
                            };

                            #define IFBIF_LEARNING  0x1 /* learns addrs */
                            #define IFBIF_DISCOVER  0x2 /* gets fwd'd pkts */

                            struct ifbifconf {
                                    char ifbic_name[IFNAMSIZ]; /* brdg name */
                                    u_int32_t       ifbic_len; /* buf size */
                                    union {
                                            caddr_t ifbicu_buf; /* buffer */
                                            struct  ifbreq *ifbicu_req;
                                    } ifbic_ifbicu;
                            #define ifbic_buf       ifbic_ifbicu.ifbicu_buf
                            #define ifbic_req       ifbic_ifbicu.ifbicu_req
                            };

     SIOCBRDGADD      (struct ifbreq) Add the interface named in ifbr_ifsname
                      to the bridge named in ifbr_name.

     SIOCBRDGDEL      (struct ifbreq) Delete the interface named in
                      ifbr_ifsname from the bridge named in ifbr_name.

     SIOCBRDGADDS     (struct ifbreq) Add the interface named in ifbr_ifsname
                      as a span port to the bridge named in ifbr_name.

     SIOCBRDGDELS     (struct ifbreq) Delete the interface named in
                      ifbr_ifsname from the list of span ports of the bridge
                      named in ifbr_name.

     SIOCBRDGSIFFLGS  (struct ifbreq) Set the bridge member interface flags
                      for the interface named in ifbr_ifsname attached to the
                      bridge ifbr_name. If the flag IFBIF_LEARNING is set on
                      an interface, source addresses from frames received on
                      the interface are recorded in the address cache.  If the
                      flag IFBIF_DISCOVER is set, the interface will receive
                      packets destined for unknown destinations, otherwise a
                      frame that has a destination not found in the address
                      cache is not forwarded to this interface.  The default
                      for newly added interfaces has both flags set.  If the
                      flag IFBIF_BLOCKNONIP is set, packets that are one of
                      ip(4), ip6(4), arp(4), or Reverse ARP, will not be
                      bridged from and to the interface.

     SIOCBRDGGIFFLGS  Retrieve the bridge member interface flags for the in-
                      terface named in ifbr_ifsname attached to the bridge
                      ifbr_name.

     SIOCBRDGRTS      (struct ifbaconf) Retrieve the address cache of the
                      bridge named in ifbac_name. This request takes an
                      ifbaconf structure (see below) as a value result parame-
                      ter.  The ifbac_len field should be initially set to the
                      size of the buffer pointed to by ifbac_buf. On return,
                      it will contain the length, in bytes, of the configura-
                      tion list.  Alternatively, if the ifbac_len passed in is
                      set to 0, SIOCBRDGRTS will set it to the size that
                      ifbac_buf needs to be to fit the entire configuration
                      list and not fill in the other parameters.  As with
                      SIOCBRDGIFS, this is useful for determining the exact
                      size that ifbac_buf needs to be in advance.

                      The argument structure is defined as follows:

                            struct ifbareq {
                                    char ifba_name[IFNAMSIZ];   /* brdg nam */
                                    char ifba_ifsname[IFNAMSIZ];/* dest ifs */
                                    u_int8_t ifba_age;          /* addr age */
                                    u_int8_t ifba_flags;        /* addr flag */
                                    struct ether_addr ifba_dst; /* dst addr */
                            };

                            #define IFBAF_TYPEMASK 0x03  /* addr type mask */
                            #define IFBAF_DYNAMIC  0x00  /* dynamic addr */
                            #define IFBAF_STATIC   0x01  /* static address */

                            struct ifbaconf {
                                    char ifbac_name[IFNAMSIZ]; /* brdg name */
                                    u_int32_t ifbac_len;       /* buf size */
                                    union {
                                            caddr_t ifbacu_buf;     /* buf */
                                            struct ifbareq *ifbacu_req;
                                    } ifbac_ifbacu;
                            #define ifbac_buf       ifbac_ifbacu.ifbacu_buf
                            #define ifbac_req       ifbac_ifbacu.ifbacu_req
                            };
                      Address cache entries with the type set to IFBAF_DYNAMIC
                      in ifba_flags are entries learned by the bridge.  En-
                      tries with the type set to IFBAF_STATIC are manually
                      added entries.

     SIOCBRDGSADDR    (struct ifbareq) Add an entry, manually, to the address
                      cache for the bridge named in ifba_name. The address and
                      its associated interface and flags are set in the
                      ifba_dst, ifba_ifsname, and ifba_flags fields, respec-
                      tively.

     SIOCBRDGDADDR    (struct ifbareq) Delete an entry from the address cache
                      of the bridge named in ifba_name. Entries are deleted
                      strictly based on the address field ifba_dst.

     SIOCBRDGSCACHE   (struct ifbcachereq) Set the maximum address cache size
                      for the bridge named in ifbc_name to ifbc_size entries.

                      The argument structure is as follows:

                            struct ifbcachereq {
                                    char ifbc_name[IFNAMSIZ]; /* bridge */
                                    u_int32_t ifbc_size;      /* size */
                            };

     SIOCBRDGGCACHE   (struct ifbcachereq) Retrieve the maximum size of the
                      address cache for the bridge ifbc_name.

     SIOCBRDGSTO      (struct ifbcachetoreq) Set the time, in seconds, that
                      addresses which have not been seen on the network
                      (transmitted a packet) remain in the cache.  If the time
                      is set to zero, no aging is performed on the address
                      cache.  The argument structure is as follows:

                            struct ifbcachetoreq {
                                    char ifbct_name[IFNAMSIZ]; /* bridge */
                                    u_int32_t ifbct_time;      /* time */
                            };

     SIOCBRDGGTO      (struct ifbcachetoreq) Retrieve the address cache expi-
                      ration time (see above).

     SIOCBRDGFLUSH    (struct ifbreq) Flush addresses from the cache.
                      ifbr_name contains the name of the bridge device, and
                      ifbr_ifsflags should be set to IFBF_FLUSHALL to flush
                      all addresses from the cache or IFBF_FLUSHDYN to flush

                      only the dynamically learned addresses from the cache.

     SIOCBRDGARL      (struct ifbrlreq) Add a Ethernet address filtering rule
                      to the bridge on a specific interface.  The argument
                      structure is as follows:


     SIOCBRDGFRL      (struct ifbrlreq) Remove all filtering rules from a
                      bridge interface member.  ifbr_name contains the name of
                      the bridge device, and ifbr_ifsname contains the name of
                      the bridge member interface.

     SIOCBRDGGRL      (struct ifbrlconf) Retrieve all of the rules from the
                      bridge, ifbrl_name, for the member interface,
                      ifbrl_ifsname. This request takes an ifbrlconf structure
                      (see below) as a value result parameter.  The ifbrl_len
                      field should be initially set to the size of the buffer
                      pointed to by ifbrl_buf. On return, it will contain the
                      length, in bytes, of the configuration list.  Alterna-
                      tively, if the ifbrl_len passed in is set to 0,
                      SIOCBRDGGRL will set it to the size that ifbrl_buf needs
                      to be to fit the entire configuration list and not fill
                      in the other parameters.  As with SIOCBRDGIFS, this is
                      useful for determining the exact size that ifbrl_buf
                      needs to be in advance.

                      The argument structure is defined as follows:

                            struct ifbrlconf {
                                    char ifbrl_name[IFNAMSIZ];   /* brdg nam */
                                    char ifbrl_ifsname[IFNAMSIZ];/* ifs name */
                                    u_int32_t ifbr_len;         /* buf len */
                                    union {
                                            caddr_t ifbrlu_buf;
                                            struct ifbrlreq *ifbrlu_req;
                                    } ifrl_ifbrlu;
                            #define ifbrl_buf ifbrl_ifbrlu.ifbrlu_buf
                            #define ifbrl_req ifbrl_ifbrlu.ifbrlu_req
                            };

     SIOCBRDGARL      (struct ifbrlreq) Add a filtering rule to the bridge
                      named in ifbr_name on the interface named in
                      ifbr_ifsname. The argument structure is as follows:

                            struct ifbrlreq {
                                    char ifbr_name[IFNAMSIZ];    /* bridge */
                                    char ifbr_ifsname[IFNAMSIZ]; /* ifs */
                                    u_int8_t ifbr_action;        /* handling */
                                    u_int8_t ifbr_flags;         /* flags */
                                    struct ether_addr ifbr_src;  /* src mac */
                                    struct ether_addr ifbr_dst;  /* dst mac */
                            };
                            #define BRL_ACTION_BLOCK        0x01
                            #define BRL_ACTION_PASS         0x02
                            #define BRL_FLAG_IN             0x08
                            #define BRL_FLAG_OUT            0x04
                            #define BRL_FLAG_SRCVALID       0x02
                            #define BRL_FLAG_DSTVALID       0x01

                      Rules are applied in the order in which they were added
                      to the bridge, and the first matching rule's action pa-
                      rameter determines the fate of the packet.  The
                      ifbr_action parameter specifies whether a frame matching
                      the rule is to be blocked or passed.

                      If the BRL_FLAG_IN bit is set in ifbr_flags, then the
                      rule applies to frames received by the interface.  If
                      the BRL_FLAG_OUT bit is set, then the rule applies to
                      frame transmitted by the interface.  At least one of
                      BRL_FLAG_IN or BRL_FLAG_OUT must be set.

                      The source Ethernet address in ifbr_src is checked if
                      the BRL_FLAG_SRCVALID bit is set in ifbr_flags. The des-
                      tination address in ifbr_dst is check if the
                      BRL_FLAG_DSTVALID bit is set.  If neither bit is set,
                      the rule is matches all frames.

     SIOCBRDGFRL      (struct ifbrlreq) Flush rules from the bridge ifbr_name
                      on the interface ifbr_ifsname.

     SIOCBRDGGRL      (struct ifbrlconf) Retrieve an array of rules from the
                      bridge for a particular interface.  This request takes
                      an ifbrlconf structure (see below) as a value-result pa-
                      rameter.  The ifbrl_len field should be initially set to
                      the size of the buffer pointed to by ifbrl_buf. On re-
                      turn it will contain the length, in bytes, of the rule
                      list.  Alternatively, if the ifbrl_len passed in is set
                      to 0, SIOCBRDGGRL will set ifbrl_len to the size that
                      ifbrl_buf needs to be to fit the entire configuration
                      list, and will not fill in the other parameters.  This
                      is useful for determining the exact size that ifbrl_buf
                      needs to be in advance.

                      The argument structure is as follows:

                            struct ifbrlconf {
                                    char ifbrl_name[IFNAMSIZ];   /* bridge */
                                    char ifbrl_ifsname[IFNAMSIZ];/* member */
                                    u_int32_t ifbrl_len;         /* buflen */
                                    union {
                                            caddr_t ifbrlu_buf;
                                            struct  ifbrlreq *ifbrlu_req;
                                    } ifbrl_ifbrlu;
                            #define ifbrl_buf ifbrl_ifbrlu.ifbrlu_buf
                            #define ifbrl_req ifbrl_ifbrlu.ifbrlu_req
                            };
