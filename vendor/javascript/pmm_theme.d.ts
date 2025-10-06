const pmmtheme = { 
  functions: { 
      showAlert: ( 
          message: string, 
          type: string, 
          container: string, 
          timeout: number 
      ): void => {}, 
      showToast: ( 
          id: string, 
          autohide: boolean, 
          delay: number, 
          options: unknown 
      ): void => {}, 
  }, 
}; 

// export as namespace 
export as namespace pmmtheme; 

// export as default 
export default pmmtheme; 
